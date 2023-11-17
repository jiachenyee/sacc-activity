//
//  DiscordManager.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 13/11/23.
//

import Foundation
import DiscordBM
import AsyncHTTPClient

class DiscordManager: ObservableObject {
    
    @Published var activityGroups = (1...9).map {
        ActivityGroup(groupName: "Group \($0)")
    }
    
    @Published var presentedSceneIDs: Set<UUID> = []
    
    @Published var currentScene: ActivitySubscene = .init(systemImage: "", title: "", state: .empty) {
        didSet {
            oldValue.onEnd?(self)
            currentScene.onStart?(self)
        }
    }
    
    @Published var currentActivitySceneIndex = 0
    
    @Published var activeSlashCommand: String?
    
    @Published var submissions: [Submission] = []
    
    @Published var activityScenes: [any ActivityScene] = [
        WelcomeActivityScene(),
        FlagCreationActivityScene(),
        AppIdeaActivityScene(),
        TriviaActivityScene()
    ]
    
    let discordInfo = DiscordInfo.getInformation()
    
    var bot: BotGatewayManager?
    
    init() {
        Task.detached {
            await self.initialize()
        }
    }
    
    func initialize() async {
        
        let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)

        self.bot = await BotGatewayManager(
            eventLoopGroup: httpClient.eventLoopGroup,
            httpClient: httpClient,
            token: discordInfo.token,
            presence: .init(
                activities: [.init(name: "YJ teach Swift Accelerator classes", type: .listening)],
                status: .online,
                afk: false),
            intents: Gateway.Intent.allCases
        )
        
        await bot?.connect()
        
        await setUpSlashCommands()
        
        for await event in await bot!.events {
            EventHandler(event: event, client: bot!.client, activeCommand: activeSlashCommand) { [self] (interaction, applicationCommand) in
                
                guard let channelName = interaction.channel?.name,
                      let groupIndex = channelName.split(separator: " ").last else { return }
                
                let groupReferenceIndex = ((Int(groupIndex) ?? 1) - 1)
                
                switch applicationCommand.name {
                case "flag":
                    guard let attachment = applicationCommand.resolved?.attachments?.first,
                          let imageURL = URL(string: attachment.value.url) else { return }
                    
                    Task {
                        await MainActor.run {
                            activityGroups[groupReferenceIndex].flagURL = imageURL
                            print(imageURL)
                            self.submissions.append(Submission(activityGroup: activityGroups[groupReferenceIndex],
                                                               contents: .flag))
                        }
                    }
                default: break
                }
                
            }.handle()
        }
    }
}

struct EventHandler: GatewayEventHandler, @unchecked Sendable {
    let event: Gateway.Event
    let client: any DiscordClient
    let activeCommand: String?
    
    let onSuccess: ((Interaction, Interaction.ApplicationCommand) -> ())
    
    func onInteractionCreate(_ interaction: Interaction) async throws {
        switch interaction.data {
        case let .applicationCommand(applicationCommand):
            guard let channelName = interaction.channel?.name,
                  channelName.starts(with: "group-") || channelName == "bot-logging" else {
                try await client.createInteractionResponse(
                    id: interaction.id,
                    token: interaction.token,
                    payload: .channelMessageWithSource(.init(content: "You can only use this command in your group’s channel.",
                                                             flags: [.ephemeral]))
                ).guardSuccess()
                
                return
            }
            guard activeCommand == applicationCommand.name else {
                try await client.createInteractionResponse(
                    id: interaction.id,
                    token: interaction.token,
                    payload: .channelMessageWithSource(.init(content: "Submission for this activity is not open yet!",
                                                             flags: [.ephemeral]))
                ).guardSuccess()
                
                return
            }
            
            try await client.createInteractionResponse(
                id: interaction.id,
                token: interaction.token,
                payload: .channelMessageWithSource(.init(content: "Thanks for your submission!\n\nUse this command again to replace the current submission."))
            ).guardSuccess()
            
            onSuccess(interaction, applicationCommand)
        default: break
        }
    }
}
