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
}
