//
//  AppIdeaActivityScene.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 15/11/23.
//

import Foundation
import SwiftUI
import DiscordBM

struct AppIdeaActivityScene: ActivityScene {
    
    var systemName = "app.gift"
    var title = "App Idea-athon"
    
    var body: some View {
        EmptyView()
    }
    
    func createCommands() -> [Command]? {
        [
            Command(name: "idea",
                    description: "Submit an app idea for the App Idea-athon activity.",
                    options: [.init(type: .string,
                                    name: "idea",
                                    description: "Describe your app idea!",
                                    required: true)])
        ]
    }
    
    var scenes: [ActivitySubscene] = [
        ActivitySubscene(systemImage: "hand.wave",
                         title: "Activity Intro",
                         state: .activityTitle("App Idea-athon", "activity 2")),
        ActivitySubscene(systemImage: "text.word.spacing",
                         title: "Brief: Words",
                         state: .statement("There is a list of 50 random words.")),
        ActivitySubscene(systemImage: "list.clipboard",
                         title: "Brief: App Idea",
                         state: .statement("Create an app idea that contains the most number of those words!")),
        ActivitySubscene(systemImage: "medal",
                         title: "Brief: Prizes",
                         state: .pointers([
                            Pointer(systemName: "medal.fill", title: "Most Random Words Used", color: .yellow),
                            Pointer(systemName: "medal.fill", title: "Most Ridiculous Idea", color: .yellow, subtitle: "Judged by YJ")
                         ])),
        ActivitySubscene(systemImage: "text.redaction",
                         title: "Words List",
                         state: .words),
        ActivitySubscene(systemImage: "timer", title: "Activity Timer",
                         state: .timer(TimerInput(content: .wordsList, endDate: .init(timeIntervalSince1970: 1700290800)))),
        // TODO: Add text review view
        ActivitySubscene(systemImage: "flag.filled.and.flag.crossed", title: "Leaderboard", state: .leaderboards)
    ]
}
