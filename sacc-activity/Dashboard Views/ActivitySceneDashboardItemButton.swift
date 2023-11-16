//
//  ActivitySceneDashboardItemButton.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct ActivitySceneDashboardItemButton: View {
    
    @EnvironmentObject var discordManager: DiscordManager
    
    @Binding var scene: ActivitySubscene
    
    @State private var endDate = Date.now
    
    var action: (() -> Void)
    
    var body: some View {
        switch scene.state {
        case .timer(let timer):
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: scene.systemImage)
                        .font(.largeTitle)
                    Spacer()
                    
                    if discordManager.presentedSceneIDs.contains(scene.id) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.green)
                    }
                }
                .frame(height: 32, alignment: .top)
                .padding(.bottom, 8)
                
                Text(scene.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                DatePicker(selection: $endDate,
                           displayedComponents: [.date, .hourAndMinute]) {
                    EmptyView()
                }
                
                Button("Start") {
                    var timer = timer
                    timer.endDate = endDate
                    timer.startDate = .now
                    scene.state = .timer(timer)
                    
                    action()
                }
            }
            .frame(height: 156, alignment: .top)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(discordManager.currentScene.id == scene.id ? .ultraThinMaterial : .ultraThickMaterial)
            .clipShape(.rect(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.primary, lineWidth: discordManager.currentScene.id == scene.id ? 4 : 0)
            }
            .onAppear {
                endDate = timer.endDate
            }
        default:
            Button {
                action()
            } label: {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Image(systemName: scene.systemImage)
                            .font(.largeTitle)
                        Spacer()
                        
                        if discordManager.presentedSceneIDs.contains(scene.id) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title)
                                .foregroundStyle(.green)
                        }
                    }
                    .frame(height: 32, alignment: .top)
                    .padding(.bottom, 8)
                    
                    Text(scene.title)
                        .font(.title)
                        .fontWeight(.bold)
                }
                .frame(height: 156, alignment: .top)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(discordManager.currentScene.id == scene.id ? .ultraThinMaterial : .ultraThickMaterial)
                .clipShape(.rect(cornerRadius: 8))
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.primary, lineWidth: discordManager.currentScene.id == scene.id ? 4 : 0)
                }
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    ActivitySceneDashboardItemButton(scene: .constant(.init(systemImage: "", title: "", state: .empty))) {
        
    }
}
