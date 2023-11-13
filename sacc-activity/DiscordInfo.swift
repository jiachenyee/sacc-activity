//
//  DiscordInfo.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 13/11/23.
//

import Foundation

struct DiscordInfo: Codable {
    var token: String
    var applicationId: String
    
    static func getInformation() -> Self {
        let path = Bundle.main.path(forResource: "Discord", ofType: "plist")!
        let data = FileManager.default.contents(atPath: path)!
        return try! PropertyListDecoder().decode(Self.self, from: data)
    }
}
