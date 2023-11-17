//
//  PresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct PresentationView: View {
    
    @Namespace var namespace
    
    @EnvironmentObject var discordManager: DiscordManager
    
    var body: some View {
        ZStack {
            Color.black
            
            switch discordManager.currentScene.state {
            case .empty: EmptyView()
            case .activityTitle(let title, let subtitle):
                ActivityTitlePresentationView(title: title, subtitle: subtitle)
            case .section(let title, let subtitle):
                SectionPresentationView(title: title, subtitle: subtitle)
            case .pointers(let contents):
                PointersPresentationView(namespace: namespace, contents: contents)
            case .statement(let statement):
                StatementPresentationView(statement: statement)
            case .timer(let timer):
                TimerPresentationView(namespace: namespace, timerInput: timer)
            case .trivia(let string, let nSImage, let date):
                Rectangle().fill(.blue)
            case .submissions:
                ReviewPresentationView(submissions: discordManager.submissions)
            case .leaderboards:
                FlagRaisingLeaderboardPresentationView()
            case .image(let nsImage):
                ImagePresentationView(image: nsImage)
            case .words:
                WordsPresentationView()
            }
        }
        .foregroundStyle(.white)
        .frame(width: 1920, height: 1080)
        .aspectRatio(16/9, contentMode: .fit)
    }
}

#Preview {
    PresentationView()
}
