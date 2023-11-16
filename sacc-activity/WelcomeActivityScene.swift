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
                            Pointer(systemName: "heart.fill", title: "Be Respectful", color: .red),
                            Pointer(systemName: "bubble.left.and.text.bubble.right.fill", title: "Discuss on Discord", color: .blue),
                            Pointer(systemName: "balloon.2.fill", title: "Have Fun!", color: .yellow)
                         ]))
    ]
}
