//
//  FlagRaisingLeaderboardPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct FlagRaisingLeaderboardPresentationView: View {
    
    @EnvironmentObject var discordManager: DiscordManager
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(discordManager.activityGroups) { activityGroup in
                VStack {
                    HStack(alignment: .bottom, spacing: 0) {
                        Rectangle()
                            .fill(.white.opacity(0.5))
                            .frame(width: 15)
                        
                        Rectangle()
                            .frame(width: 180, height: 50)
                        
                        Spacer()
                    }
                    Text(activityGroup.groupName)
                        .font(.system(size: 32))
                }
            }
        }
        .padding(95)
    }
}

#Preview {
    FlagRaisingLeaderboardPresentationView()
}
