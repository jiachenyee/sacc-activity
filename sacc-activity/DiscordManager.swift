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
    
    @Published var activityGroups = [
        ActivityGroup(groupName: "1AM"),
        ActivityGroup(groupName: "2AM"),
        ActivityGroup(groupName: "3AM"),
        ActivityGroup(groupName: "4AM"),
        ActivityGroup(groupName: "5AM"),
        ActivityGroup(groupName: "6AM"),
        ActivityGroup(groupName: "7AM"),
        ActivityGroup(groupName: "8AM"),
        ActivityGroup(groupName: "1PM"),
        ActivityGroup(groupName: "2PM"),
        ActivityGroup(groupName: "3PM"),
        ActivityGroup(groupName: "4PM"),
        ActivityGroup(groupName: "5PM"),
        ActivityGroup(groupName: "6PM"),
        ActivityGroup(groupName: "7PM"),
        ActivityGroup(groupName: "8PM"),
    ]

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
        TriviaActivityScene(),
        ClosingActivityScene()
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
                activities: [.init(name: "Taylor Swift", type: .listening)],
                status: .online,
                afk: false),
            intents: Gateway.Intent.allCases
        )

        await bot?.connect()

        await setUpSlashCommands()

        for await event in await bot!.events {
            EventHandler(event: event, client: bot!.client, activeCommand: activeSlashCommand) { [self] (interaction, applicationCommand) in
                
                guard let channelName = interaction.channel?.name,
                      let groupReferenceIndex = activityGroups.firstIndex(where: {
                          $0.groupName == channelName
                      }) else { return }
                
                switch applicationCommand.name {
                case "flag":
                    guard let attachment = applicationCommand.resolved?.attachments?.first,
                          let imageURL = URL(string: attachment.value.url) else { return }
                    
                    Task {
                        await MainActor.run {
                            activityGroups[groupReferenceIndex].flagURL = imageURL
                            print(imageURL)
                            self.submissions.append(Submission(activity: "flag",
                                                               activityGroup: activityGroups[groupReferenceIndex],
                                                               contents: .flag))
                        }
                    }
                case "story":
                    guard let value = applicationCommand.options?.first?.value?.asString else { return }
                    Task {
                        await MainActor.run {
                            self.submissions.append(Submission(activity: "idea",
                                                               activityGroup: activityGroups[groupReferenceIndex],
                                                               contents: .text(value)))
                        }
                    }
                case "q1", "q8", "q11", "q14", "q15":
                    guard let value = applicationCommand.options?.first?.value?.asString else { return }
                    Task {
                        await MainActor.run {
                            self.submissions.append(Submission(activity: applicationCommand.name,
                                                               activityGroup: activityGroups[groupReferenceIndex],
                                                               contents: .text(value)))
                        }
                    }
                case "q2", "q3", "q4", "q5", "q6", "q7", "q10", "q12", "q13":
                    guard let value = try? applicationCommand.options?.first?.value?.requireInt() else { return }
                    
                    Task {
                        let targetValues = [
                            "q2": 3,
                            "q3": 1983,
                            "q4": 2019,
                            "q5": 2018,
                            "q6": 18,
                            "q7": 2019,
                            "q10": 17,
                            "q12": 1197,
                            "q13": 13
                        ]
                        
                        let targetValue: Int = targetValues[applicationCommand.name]!
                        let offset = targetValue - value
                        
                        if offset == 0 {
                            await MainActor.run {
                                self.submissions.append(Submission(activity: applicationCommand.name,
                                                                   activityGroup: activityGroups[groupReferenceIndex],
                                                                   contents: .text("Perfect!")))
                            }
                        } else if offset < 0 {
                            await MainActor.run {
                                self.submissions.append(Submission(activity: applicationCommand.name,
                                                                   activityGroup: activityGroups[groupReferenceIndex],
                                                                   contents: .triviaSubmission("\(value)", "\(abs(offset)) over")))
                            }
                        } else {
                            await MainActor.run {
                                self.submissions.append(Submission(activity: applicationCommand.name,
                                                                   activityGroup: activityGroups[groupReferenceIndex],
                                                                   contents: .triviaSubmission("\(value)", "\(abs(offset)) under")))
                            }
                        }
                    }
                case "q9":
                    guard let options = applicationCommand.options,
                          options.count == 2,
                            let latitude = try? options[0].requireDouble(),
                            let longitude = try? options[1].requireDouble() else { return }
                    
                    let coords = [
                        "q9": (1.289072, 103.856147)
                    ]
                    
                    let distance = haversineDistance(coord1: (latitude: latitude, longitude: longitude), coord2: coords[applicationCommand.name]!)
                    
                    Task {
                        await MainActor.run {
//                            self.submissions.append(Submission(activity: applicationCommand.name,
//                                                               activityGroup: activityGroups[groupReferenceIndex],
//                                                               contents: .triviaSubmission("(\(latitude), \(longitude))", "\(distance) KM")))
                            self.submissions.append(Submission(activity: applicationCommand.name,
                                                               activityGroup: activityGroups[groupReferenceIndex],
                                                               contents: .triviaMap((latitude, longitude), "\(distance) KM")))
                        }
                    }
//                    Task {
//                        await MainActor.run {
//                            self.submissions.append(Submission(activity: applicationCommand.name,
//                                                               activityGroup: activityGroups[groupReferenceIndex],
//                                                               contents: .text("\(value)")))
//                        }
//                    }
                default: break
                }
                
            }.handle()
        }
    }
    
    func haversineDistance(coord1: (latitude: Double, longitude: Double), coord2: (latitude: Double, longitude: Double)) -> Double {
        let earthRadius: Double = 6371 // Earth radius in kilometers
        
        // Convert latitude and longitude from degrees to radians
        let lat1 = coord1.latitude * .pi / 180.0
        let lon1 = coord1.longitude * .pi / 180.0
        let lat2 = coord2.latitude * .pi / 180.0
        let lon2 = coord2.longitude * .pi / 180.0
        
        // Calculate differences
        let dLat = lat2 - lat1
        let dLon = lon2 - lon1
        
        // Haversine formula
        let a = sin(dLat / 2) * sin(dLat / 2) + cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        // Distance in kilometers
        let distance = earthRadius * c
        
        return distance
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
            let groups = [
                "1AM",
                "2AM",
                "3AM",
                "4AM",
                "5AM",
                "6AM",
                "7AM",
                "8AM",
                "1PM",
                "2PM",
                "3PM",
                "4PM",
                "5PM",
                "6PM",
                "7PM",
                "8PM"
            ]
            
            guard let channelName = interaction.channel?.name,
                  groups.contains(channelName) || channelName == "bot-logging" else {
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
