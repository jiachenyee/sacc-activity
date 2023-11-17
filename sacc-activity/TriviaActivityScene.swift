//
//  TriviaActivityScene.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 15/11/23.
//

import Foundation
import SwiftUI
import DiscordBM

struct TriviaActivityScene: ActivityScene {
    var systemName = "questionmark.bubble"
    var title = "Terribly Tricky Trivia"
    
    var body: some View {
        EmptyView()
    }
    
    func createCommands() -> [Command]? {
        [
            Command(name: "q1",
                    description: "Submit your answer for Trivia Question 1",
                    options: [.init(type: .string,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q2",
                    description: "Submit your answer for Trivia Question 2",
                    options: [.init(type: .string,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q3",
                    description: "Submit your answer for Trivia Question 3",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q4",
                    description: "Submit your answer for Trivia Question 4",
                    options: [.init(type: .string,
                                    name: "answer",
                                    description: "Enter your answer", required: true,
                                    choices: [
                                        .init(name: "January", value: .string("Jan")),
                                        .init(name: "February", value: .string("Feb")),
                                        .init(name: "March", value: .string("Mar")),
                                        .init(name: "April", value: .string("Apr")),
                                        .init(name: "May", value: .string("May")),
                                        .init(name: "June", value: .string("Jun")),
                                        .init(name: "July", value: .string("Jul")),
                                        .init(name: "August", value: .string("Aug")),
                                        .init(name: "September", value: .string("Sep")),
                                        .init(name: "October", value: .string("Oct")),
                                        .init(name: "November", value: .string("Nov")),
                                        .init(name: "December", value: .string("Dec")),
                                    ],
                                    autocomplete: false)]),
            Command(name: "q5",
                    description: "Submit your answer for Trivia Question 5",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true,
                                    min_value: .int(1000),
                                    max_value: .int(9999))]),
            Command(name: "q6",
                    description: "Submit your answer for Trivia Question 6",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true,
                                    min_value: .int(1000),
                                    max_value: .int(9999))]),
            Command(name: "q7",
                    description: "Submit your answer for Trivia Question 6",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q8",
                    description: "Submit your answer for Trivia Question 8",
                    options: [.init(type: .number,
                                    name: "latitude",
                                    description: "Enter your answer",
                                    required: true),
                              .init(type: .number,
                                    name: "longitude",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q9",
                    description: "Submit your answer for Trivia Question 9",
                    options: [.init(type: .number,
                                    name: "latitude",
                                    description: "Enter your answer",
                                    required: true),
                              .init(type: .number,
                                    name: "longitude",
                                    description: "Enter your answer",
                                    required: true)])
        ]
    }
    
    var scenes: [ActivitySubscene] = [
        ActivitySubscene(systemImage: "hand.wave",
                         title: "Activity Intro",
                         state: .activityTitle("Terribly Tricky Trivia", "activity 3")),
        ActivitySubscene(systemImage: "list.clipboard",
                         title: "Briefing",
                         state: .pointers([
                            Pointer(systemName: "person.fill.questionmark", title: "Answer Questions", color: .yellow, subtitle: "There are 9 trivia questions, you can discuss in your voice channels."),
                            Pointer(systemName: "timer", title: "Clock’s Ticking!", color: .orange, subtitle: "Questions will either have 30 seconds, 1 minute, or 2 minutes for you to answer!"),
                            Pointer(systemName: "scope", title: "Accuracy First", color: .red, subtitle: "It’s not about speed, it’s accuracy. Points are awarded based on the closest to the actual answer."),
                            Pointer(systemName: "command", title: "Slash Commands!", color: .purple, subtitle: "We’ll use slash commands like `/q1` to `/q9` for this.")
                         ])),
        ActivitySubscene(systemImage: "flag.filled.and.flag.crossed", title: "Leaderboard", state: .leaderboards),
        
        ActivitySubscene(systemImage: "1.circle", title: "Q1: Apple logo",
                         state: .trivia(60, "What fruit inspired the Apple logo?", 1, nil),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q1"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "1.square", title: "Q1 Answer", state: .statement("**Pear**, no but seriously, it's Apple")),
        ActivitySubscene(systemImage: "1.circle.fill", title: "Q1 Review", state: .submissions("q1")),
        
        ActivitySubscene(systemImage: "2.circle", title: "Q2: Apple Stores",
                         state: .trivia(45, "How many Apple Stores are there in Singapore and the UAE combined?", 2, nil),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q2"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "2.square", title: "Q2 Answer", state: .statement("7")),
        ActivitySubscene(systemImage: "2.circle.fill", title: "Q2 Review", state: .submissions("q2")),
        
        ActivitySubscene(systemImage: "3.circle", title: "Q3: App Store Apps",
                         state: .trivia(45, "How many apps are there on the App Store as of 2022?", 3, nil),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q3"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "3.square", title: "Q3 Answer", state: .statement("1,783,232")),
        ActivitySubscene(systemImage: "3.circle.fill", title: "Q3 Review", state: .submissions("q3")),
        
        ActivitySubscene(systemImage: "4.circle", title: "Q4: SSC Month",
                         state: .trivia(45, "What month will the Swift Student Challenge 2024 open for submissions?", 4, nil),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q4"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "4.square", title: "Q4 Answer", state: .statement("February")),
        ActivitySubscene(systemImage: "4.circle.fill", title: "Q4 Review", state: .submissions("q4")),
        
        ActivitySubscene(systemImage: "5.circle", title: "Q5: First WWDC",
                         state: .trivia(45, "Which year was the first WWDC held?", 5, nil),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q5"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "5.square", title: "Q5 Answer", state: .statement("1983")),
        ActivitySubscene(systemImage: "5.circle.fill", title: "Q5 Review", state: .submissions("q5")),
        
        ActivitySubscene(systemImage: "6.circle", title: "Q6: SwiftUI Release",
                         state: .trivia(45, "Which year was SwiftUI released?", 6, nil),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q6"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "6.square", title: "Q6 Answer", state: .statement("2019")),
        ActivitySubscene(systemImage: "6.circle.fill", title: "Q6 Review", state: .submissions("q6")),
        
        ActivitySubscene(systemImage: "7.circle", title: "Q7: Ppl in Discord",
                         state: .trivia(45, "How many people are there in the Discord server?", 7, nil),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q7"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "7.square", title: "Q7 Answer", state: .statement("Check Discord")), // TODO: update this
        ActivitySubscene(systemImage: "7.circle.fill", title: "Q7 Review", state: .submissions("q7")),
        
        ActivitySubscene(systemImage: "8.circle", title: "Q8: GeoGusser SG",
                         state: .trivia(120, "Where was this picture taken in Singapore? Submit the lat and long.", 8, .SG),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q8"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "8.square", title: "Q8 Answer", state: .statement("1.289072, 103.856147")),
        ActivitySubscene(systemImage: "8.circle.fill", title: "Q8 Review", state: .submissions("q8")),
        
        ActivitySubscene(systemImage: "9.circle", title: "Q9: GeoGusser UAE",
                         state: .trivia(120, "Where was this picture taken in the UAE? Submit the lat and long.", 9, .UAE),
                         onStart: { discordManager in
                             discordManager.activeSlashCommand = "q9"
                         }, onEnd: { discordManager in
                             discordManager.activeSlashCommand = nil
                         }),
        ActivitySubscene(systemImage: "9.square", title: "Q9 Answer", state: .statement("25.195645, 55.277522")),
        ActivitySubscene(systemImage: "9.circle.fill", title: "Q9 Review", state: .submissions("q9"))
    ]
}
