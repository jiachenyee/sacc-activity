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
    var title = "Incredible Ideas Incubator"
    
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
                         state: .activityTitle("Incredible Ideas Incubator", "activity 2")),
        ActivitySubscene(systemImage: "text.word.spacing",
                         title: "Brief: Words",
                         state: .statement("There is a list of 50 random words.")),
        ActivitySubscene(systemImage: "list.clipboard",
                         title: "Brief: App Idea",
                         state: .statement("Create an app idea that contains the most number of words from the list!")),
        ActivitySubscene(systemImage: "medal",
                         title: "Brief: Prizes",
                         state: .pointers([
                            Pointer(systemName: "medal.fill", title: "Most Random Words Used", color: .yellow),
                            Pointer(systemName: "medal.fill", title: "Most Ridiculous Idea", color: .orange, subtitle: "Judged by YJ")
                         ])),
        ActivitySubscene(systemImage: "text.redaction",
                         title: "Words List",
                         state: .words),
        ActivitySubscene(systemImage: "text.alignleft",
                         title: "Example App Idea 1",
                         state: .statement("An app that uses the _camera_ to classify _coconuts_ from _crocodiles_")),
        ActivitySubscene(systemImage: "timer", title: "Activity Timer",
                         state: .timer(TimerInput(content: .wordsList, endDate: .init(timeIntervalSince1970: 1700290800))),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "idea"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "eyes", title: "Review", state: .submissions([])),
        ActivitySubscene(systemImage: "flag.filled.and.flag.crossed", title: "Leaderboard", state: .leaderboards)
    ]
}
