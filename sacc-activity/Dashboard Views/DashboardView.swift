//
//  DashboardView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 13/11/23.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var discordManager: DiscordManager
    
    @Environment(\.openWindow) var openWindow
    
    var body: some View {
        NavigationStack {
            TabView(selection: $discordManager.currentActivitySceneIndex) {
                ForEach(0..<discordManager.activityScenes.count, id: \.self) { activitySceneIndex in
                    let activityScene = discordManager.activityScenes[activitySceneIndex]
                    
                    ActivitySceneDashboardView(activityScene: $discordManager.activityScenes[activitySceneIndex])
                        .tabItem {
                            Label(activityScene.title,
                                  systemImage: activityScene.systemName)
                        }
                }
            }
            .navigationTitle("Dashboard")
            .padding()
            .toolbar {
                Button("Show Presentation Window") {
                    openWindow(id: "presentation-view")
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
