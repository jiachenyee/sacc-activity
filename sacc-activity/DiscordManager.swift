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
    
    init() {
        Task.detached {
            await self.initialize()
        }
    }
    
    func initialize() async {
        
        let discordInfo = DiscordInfo.getInformation()
        
        let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)
        
        let bot = await BotGatewayManager(
            eventLoopGroup: httpClient.eventLoopGroup,
            httpClient: httpClient,
            token: discordInfo.token,
            presence: .init(
                activities: [.init(name: "YJ teach Swift Accelerator classes", type: .listening)],
                status: .online,
                afk: false),
            /// Add all the intents you want
            /// You can also use `Gateway.Intent.unprivileged` or `Gateway.Intent.allCases`
            intents: Gateway.Intent.allCases
        )
        
        Task {
            await bot.connect()
        }
    }
}
