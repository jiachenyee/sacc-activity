//
//  DiscordManager+SlashCommands.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 13/11/23.
//

import Foundation
import DiscordBM

extension DiscordManager {
    func setUpSlashCommands() async {
        let commands = activityScenes.flatMap { $0.createCommands() ?? [] }
        
        do {
            try await bot?.client.bulkSetGuildApplicationCommands(guildId: .init(stringLiteral: discordInfo.guildId), payload: commands).guardSuccess()
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func nukeCommands() async {
        let applicationCommands = try? await bot?.client.listGuildApplicationCommands(guildId: .init(stringLiteral: discordInfo.guildId)).decode()
        
        for command in applicationCommands ?? [] {
            try! await bot?.client.deleteGuildApplicationCommand(guildId: .init(stringLiteral: discordInfo.guildId),
                                                                 commandId: command.id)
            .guardSuccess()
        }
    }
}
