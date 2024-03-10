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
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q3",
                    description: "Submit your answer for Trivia Question 3",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true,
                                    min_value: .int(1000),
                                    max_value: .int(9999))]),
            Command(name: "q4",
                    description: "Submit your answer for Trivia Question 4",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true,
                                    min_value: .int(1000),
                                    max_value: .int(9999))]),
            Command(name: "q5",
                    description: "Submit your answer for Trivia Question 5",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q6",
                    description: "Submit your answer for Trivia Question 6",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q7",
                    description: "Submit your answer for Trivia Question 7",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true,
                                    min_value: .int(1000),
                                    max_value: .int(9999))]),
            Command(name: "q8",
                    description: "Submit your answer for Trivia Question 8",
                    options: [.init(type: .string,
                                    name: "answer",
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
                                    required: true)]),
            Command(name: "q10",
                    description: "Submit your answer for Trivia Question 10",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q11",
                    description: "Submit your answer for Trivia Question 11",
                    options: [.init(type: .string,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q12",
                    description: "Submit your answer for Trivia Question 12",
                    options: [.init(type: .string,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q13",
                    description: "Submit your answer for Trivia Question 13",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q14",
                    description: "Submit your answer for Trivia Question 14",
                    options: [.init(type: .string,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true)]),
            Command(name: "q15",
                    description: "Submit your answer for Trivia Question 15",
                    options: [.init(type: .integer,
                                    name: "answer",
                                    description: "Enter your answer",
                                    required: true,
                                    min_value: .int(1000),
                                    max_value: .int(9999))]),
        ]
    }
    
    var scenes: [ActivitySubscene] = [
        [
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
        ],
        [
            ActivitySubscene(systemImage: "1.circle", title: "Q1: Apple logo",
                             state: .trivia(60, "What fruit inspired the Apple logo?", 1, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q1"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "1.square", title: "Q1 Answer", state: .statement("**Pear**, no but seriously, it's Apple")),
            ActivitySubscene(systemImage: "1.circle.fill", title: "Q1 Review", state: .submissions("q1")),
        ],
        [
            ActivitySubscene(systemImage: "2.circle", title: "Q2: Apple Stores",
                             state: .trivia(45, "How many Apple Stores are there in Singapore?", 2, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q2"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "2.square", title: "Q2 Answer", state: .statement("3")),
            ActivitySubscene(systemImage: "2.circle.fill", title: "Q2 Review", state: .submissions("q2")),
        ],
        [
            ActivitySubscene(systemImage: "3.circle", title: "Q3: First WWDC",
                             state: .trivia(45, "Which year was the first WWDC held?", 3, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q3"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "3.square", title: "Q3 Answer", state: .statement("1983")),
            ActivitySubscene(systemImage: "3.circle.fill", title: "Q5 Review", state: .submissions("q3")),
        ],
        [
            ActivitySubscene(systemImage: "4.circle", title: "Q4: SwiftUI Release",
                             state: .trivia(45, "Which year was SwiftUI released?", 4, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q4"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "4.square", title: "Q4 Answer", state: .statement("2019")),
            ActivitySubscene(systemImage: "4.circle.fill", title: "Q4 Review", state: .submissions("q4")),
        ],
        [
            ActivitySubscene(systemImage: "5.circle", title: "Q5: SAP Featured",
                             state: .trivia(45, "How many times was Swift Accelerator featured?", 5, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q5"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "5.square", title: "Q5 Answer", state: .statement("26")),
            ActivitySubscene(systemImage: "5.circle.fill", title: "Q5 Review", state: .submissions("q5")),
        ],
        [
            ActivitySubscene(systemImage: "6.circle", title: "Q6: SSC Winners",
                             state: .trivia(45, "How many Swift Student Challenge winners have come out of this programme?", 6, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q6"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "6.square", title: "Q6 Answer", state: .statement("11")),
            ActivitySubscene(systemImage: "6.circle.fill", title: "Q6 Review", state: .submissions("q6")),
        ],
        [
            ActivitySubscene(systemImage: "7.circle", title: "Q7: Tim Cook",
                             state: .trivia(45, "Which year did Tim Cook come to Swift Accelerator?", 7, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q7"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "7.square", title: "Q7 Answer", state: .statement("2019")),
            ActivitySubscene(systemImage: "7.circle.fill", title: "Q7 Review", state: .submissions("q7")),
        ],
        [
            ActivitySubscene(systemImage: "8.circle", title: "Q8: Apple Developer Center",
                             state: .trivia(45, "Apple just launched a brand new space in Singapore, what is it?", 8, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q8"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "8.square", title: "Q8 Answer", state: .statement("Apple Developer Center, Singapore")),
            ActivitySubscene(systemImage: "8.circle.fill", title: "Q8 Review", state: .submissions("q8")),
        ],
        [
            ActivitySubscene(systemImage: "9.circle", title: "Q9: GeoGusser SG",
                             state: .trivia(120, "Where was this picture taken? Submit the lat and long.", 9, .SG),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q9"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "9.square", title: "Q9 Answer", state: .statement("1.289072, 103.856147")),
            ActivitySubscene(systemImage: "9.circle.fill", title: "Q9 Review", state: .submissions("q9")),
        ],
        [
            ActivitySubscene(systemImage: "10.circle", title: "Q10: Pizza",
                             state: .trivia(45, "How many pizzas did we order for lunch?", 10, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q10"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "10.square", title: "Q10 Answer", state: .statement("17")),
            ActivitySubscene(systemImage: "10.circle.fill", title: "Q10 Review", state: .submissions("q10")),
        ],
        [
            ActivitySubscene(systemImage: "11.circle", title: "Q11: Grammy",
                             state: .trivia(45, "What is the song that won Taylor her first grammy?", 11, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q11"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "11.square", title: "Q11 Answer", state: .statement("White Horse")),
            ActivitySubscene(systemImage: "11.circle.fill", title: "Q11 Review", state: .submissions("q11")),
        ],
        [
            ActivitySubscene(systemImage: "12.circle", title: "Q12: Middle Name",
                             state: .trivia(45, "What is Taylor's middle name?", 12, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q12"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "12.square", title: "Q12 Answer", state: .statement("Alison")),
            ActivitySubscene(systemImage: "12.circle.fill", title: "Q12 Review", state: .submissions("q12")),
        ],
        [
            ActivitySubscene(systemImage: "13.circle", title: "Q13: Lucky Number",
                             state: .trivia(45, "What is Taylor's lucky number?", 13, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q13"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "13.square", title: "Q13 Answer", state: .statement("13")),
            ActivitySubscene(systemImage: "13.circle.fill", title: "Q13 Review", state: .submissions("q13")),
        ],
        [
            ActivitySubscene(systemImage: "14.circle", title: "Q14: First Taylor's Version",
                             state: .trivia(45, "What is the first Taylor's Version album?", 14, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q14"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "14.square", title: "Q14 Answer", state: .statement("Fearless")),
            ActivitySubscene(systemImage: "14.circle.fill", title: "Q14 Review", state: .submissions("q14")),
        ],
        [
            ActivitySubscene(systemImage: "15.circle", title: "Q15: Birth Year",
                             state: .trivia(45, "When was Taylor born?", 15, nil),
                             onStart: { discordManager in
                                 discordManager.activeSlashCommand = "q15"
                             }, onEnd: { discordManager in
                                 discordManager.activeSlashCommand = nil
                             }),
            ActivitySubscene(systemImage: "15.square", title: "Q15 Answer", state: .statement("1989")),
            ActivitySubscene(systemImage: "15.circle.fill", title: "Q15 Review", state: .submissions("q15")),
        ]
    ].flatMap {
        $0
    }
}
