//
//  SectionPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct SectionPresentationView: View {
    
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 100, weight: .bold))
            Text(subtitle)
                .font(.system(size: 55, weight: .regular))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(95)
        .foregroundStyle(.white)
    }
}

#Preview {
    SectionPresentationView(title: "title", subtitle: "subtitle")
}
