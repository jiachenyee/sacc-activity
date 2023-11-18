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
            HSplitView {
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
                
                VStack {
                    Button("Show Leaderboards") {
                        withAnimation {
                            discordManager.currentScene = .init(systemImage: "", title: "", state: .leaderboards)
                        }
                    }
                    AddPointsView(groups: $discordManager.activityGroups)
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
