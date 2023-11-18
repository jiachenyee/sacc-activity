//
//  FlagRaisingLeaderboardPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct FlagRaisingLeaderboardPresentationView: View {
    
    @EnvironmentObject var discordManager: DiscordManager
    
    var sortedGroups: [ActivityGroup] {
        Array(discordManager.activityGroups.sorted(by: { $0.points > $1.points }))
    }
    
    var body: some View {
        VStack {
            ForEach(Array(sortedGroups.enumerated()), id: \.offset) { (index, group) in
                let size = sizeFor(rank: index)
                
                HStack {
                    HStack {
                        Text("\(index+1)")
                            .monospaced()
                            .frame(width: 100)
                        
                        if let trophy = trophyFor(rank: index) {
                            Image(systemName: trophy)
                                .padding(.trailing, 10)
                        }
                    }
                    .font(.system(size: size*0.8))
                    
                    Text(group.groupName)
                    Spacer()
                    Text("\(group.points)")
                        .contentTransition(.numericText())
                }
                .bold()
                .font(.system(size: size))
                .frame(height: size*1.7)
                .foregroundStyle(colorFor(rank: index))
            }
        }
        .padding(95)
        .background {
            Color.primary.colorInvert()
        }
    }
    
    func sizeFor(rank: Int) -> Double {
        switch rank {
        case 0: 90 // first place
        case 1: 75 // second place
        case 2: 60 // third place
        default: 50 // everything else
        }
    }
    
    func colorFor(rank: Int) -> Color {
        switch rank {
        case 0: Color.yellow // first place
        case 1: Color.gray // second place
        case 2: Color.brown // third place
        default: Color.primary // everything else
        }
    }
    
    func trophyFor(rank: Int) -> String? {
        switch rank {
        case 0: "trophy.fill" // first place
        case 1, 2: "medal.fill" // second, third place
        default: nil // everything else
        }
    }
}

#Preview {
    FlagRaisingLeaderboardPresentationView()
}
