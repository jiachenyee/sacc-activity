//
//  ActivityScene.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 15/11/23.
//

import Foundation
import DiscordBM
import SwiftUI

protocol ActivityScene: View, Identifiable {
    typealias Command = Payloads.ApplicationCommandCreate
    
    var systemName: String { get }
    var title: String { get }
    
    func createCommands() -> [Command]?
    
    var scenes: [ActivitySubscene] { get set }
}

extension ActivityScene {
    func createCommands() -> [Command]? { nil }
    
    var id: String { title }
    var scenes: [ActivitySubscene] {
        get { [] }
        set {}
    }
}
