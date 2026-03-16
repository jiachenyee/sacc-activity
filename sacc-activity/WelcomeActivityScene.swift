//
//  WelcomeActivityScene.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct WelcomeActivityScene: ActivityScene {
    
    var systemName = "hand.wave"
    var title = "Welcome"
    
    var body: some View {
        Text("HEllo")
    }
    
    var scenes: [ActivitySubscene] = [
        ActivitySubscene(systemImage: "rectangle.dashed",
                         title: "Blank",
                         state: .empty),
        ActivitySubscene(systemImage: "hand.wave",
                         title: "Activity Welcome",
                         state: .statement("The Activity")),
        ActivitySubscene(systemImage: "ruler",
                         title: "Rules",
                         state: .pointers([
                            Pointer(systemName: "bubble.left.and.text.bubble.right.fill", title: "Let everyone have a say!", color: .blue),
                            Pointer(systemName: "balloon.2.fill", title: "Have Fun!", color: .red),
                            Pointer(systemName: "trophy.fill", title: "Prizes may be available!", color: .yellow)
                         ])),
        ActivitySubscene(systemImage: "hand.wave",
                         title: "Group Name Title",
                         state: .activityTitle("Maniac Moniker Making", "ACTIVITY 0")),
        ActivitySubscene(systemImage: "character.textbox",
                         title: "Group Name Brief",
                         state: .pointers([
                            Pointer(systemName: "ruler", title: "There'll be limitations to what you can name your group.", color: .green),
                            Pointer(systemName: "character.textbox", title: "Come up with a group name that works within the limits.", color: .indigo),
                            Pointer(systemName: "square.and.arrow.up", title: "Share it!", color: .mint)
                         ])),
        ActivitySubscene(systemImage: "textformat.characters",
                         title: "Naming Time!",
                         state: .timer(.init(content: .wordsList, endDate: .now))),
        ActivitySubscene(systemImage: "character.textbox",
                         title: "Group Name Brief",
                         state: .statement("Share your group names!"))
    ]
}
