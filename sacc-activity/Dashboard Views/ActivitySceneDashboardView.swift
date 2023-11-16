//
//  ActivitySceneDashboardView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 15/11/23.
//

import SwiftUI

struct ActivitySceneDashboardView: View {
    
    @EnvironmentObject var discordManager: DiscordManager
    
    @Binding var activityScene: any ActivityScene
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 160, maximum: 200), spacing: 16)], alignment: .leading, spacing: 16) {
                ForEach($activityScene.scenes) { $scene in
                    ActivitySceneDashboardItemButton(scene: $scene) {
                        withAnimation {
                            discordManager.currentScene = scene
                        }
                        discordManager.presentedSceneIDs.insert(scene.id)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ActivitySceneDashboardView(activityScene: .constant(FlagCreationActivityScene()))
}
