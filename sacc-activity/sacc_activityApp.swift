//
//  sacc_activityApp.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 13/11/23.
//

import SwiftUI

@main
struct sacc_activityApp: App {
    
    @StateObject var discordManager = DiscordManager()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .preferredColorScheme(.dark)
                .environmentObject(discordManager)
        }
        
        WindowGroup(id: "presentation-view") {
            PresentationView()
                .environmentObject(discordManager)
        }
    }
}
