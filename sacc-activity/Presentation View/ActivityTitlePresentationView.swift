//
//  ActivityTitlePresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct ActivityTitlePresentationView: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Text(subtitle)
                .textCase(.uppercase)
                .font(.system(size: 36, weight: .light))
                .multilineTextAlignment(.center)
            Text(title)
                .font(.system(size: 100, weight: .semibold))
                .multilineTextAlignment(.center)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    ActivityTitlePresentationView(title: "Title", subtitle: "Subtitle")
}
