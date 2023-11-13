//
//  DiscordManager+SlashCommands.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 13/11/23.
//

import Foundation
import DiscordBM

extension DiscordManager {
    func setUpSlashCommands() async {
        let commands = [
            setUpFlagCommand(),
            setUpIdeaCommand(),
            triviaQ1(),
            triviaQ2(),
            triviaQ3(),
            triviaQ4(),
            triviaQ5(),
            triviaQ6(),
            triviaQ7(),
            triviaQ8(),
            triviaQ9()
        ]
        
        do {
            try await bot?.client.bulkSetGuildApplicationCommands(guildId: .init(stringLiteral: discordInfo.guildId), payload: commands).guardSuccess()
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func nukeCommands() async {
        let applicationCommands = try? await bot?.client.listGuildApplicationCommands(guildId: .init(stringLiteral: discordInfo.guildId)).decode()
        
        for command in applicationCommands ?? [] {
            try! await bot?.client.deleteGuildApplicationCommand(guildId: .init(stringLiteral: discordInfo.guildId),
                                                                 commandId: command.id)
            .guardSuccess()
        }
    }
    
    func setUpFlagCommand() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "flag",
                                          description: "Submit a flag for Group Flag activity.",
                                          options: [.init(type: .attachment,
                                                          name: "image",
                                                          description: "Submit your group's flag image!",
                                                          required: true)])
    }
    
    func setUpIdeaCommand() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "idea",
                                          description: "Submit an app idea for the App Idea-athon activity.",
                                          options: [.init(type: .string,
                                                          name: "idea",
                                                          description: "Describe your app idea!",
                                                          required: true)])
    }
    
    func triviaQ1() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q1",
                                          description: "Submit your answer for Trivia Question 1",
                                          options: [.init(type: .string,
                                                          name: "answer",
                                                          description: "Enter your answer",
                                                          required: true)])
    }
    
    func triviaQ2() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q2",
                                          description: "Submit your answer for Trivia Question 2",
                                          options: [.init(type: .string,
                                                          name: "answer",
                                                          description: "Enter your answer",
                                                          required: true)])
    }
    
    func triviaQ3() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q3",
                                          description: "Submit your answer for Trivia Question 3",
                                          options: [.init(type: .integer,
                                                          name: "answer",
                                                          description: "Enter your answer",
                                                          required: true)])
    }
    
    func triviaQ4() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q4",
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
                                                          autocomplete: false)])
    }
    
    func triviaQ5() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q5",
                                          description: "Submit your answer for Trivia Question 5",
                                          options: [.init(type: .integer,
                                                          name: "answer",
                                                          description: "Enter your answer",
                                                          required: true,
                                                          min_value: .int(1000),
                                                          max_value: .int(9999))])
    }
    
    func triviaQ6() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q6",
                                          description: "Submit your answer for Trivia Question 6",
                                          options: [.init(type: .integer,
                                                          name: "answer",
                                                          description: "Enter your answer",
                                                          required: true,
                                                          min_value: .int(1000),
                                                          max_value: .int(9999))])
    }
    
    func triviaQ7() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q7",
                                          description: "Submit your answer for Trivia Question 6",
                                          options: [.init(type: .integer,
                                                          name: "answer",
                                                          description: "Enter your answer",
                                                          required: true)])
    }
    
    func triviaQ8() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q8",
                                          description: "Submit your answer for Trivia Question 8",
                                          options: [.init(type: .number,
                                                          name: "latitude",
                                                          description: "Enter your answer",
                                                          required: true),
                                                    .init(type: .number,
                                                          name: "longitude",
                                                          description: "Enter your answer",
                                                          required: true)])
    }
    
    func triviaQ9() -> Payloads.ApplicationCommandCreate {
        Payloads.ApplicationCommandCreate(name: "q9",
                                          description: "Submit your answer for Trivia Question 9",
                                          options: [.init(type: .number,
                                                          name: "latitude",
                                                          description: "Enter your answer",
                                                          required: true),
                                                    .init(type: .number,
                                                          name: "longitude",
                                                          description: "Enter your answer",
                                                          required: true)])
    }
}
