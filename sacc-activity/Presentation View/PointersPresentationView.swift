//
//  PointersPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct PointersPresentationView: View {
    
    var namespace: Namespace.ID
    
    var contents: [Pointer]
    
    var body: some View {
        HStack(alignment: .top) {
            ForEach(contents, id: \.title) { content in
                VStack {
                    Image(systemName: content.systemName)
                        .font(.system(size: 100, weight: .regular))
                        .frame(width: 120, height: 120)
                        .foregroundStyle(content.color)
                    Text(content.title)
                        .font(.system(size: 55, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    Text(try! AttributedString(markdown: content.subtitle))
                        .font(.system(size: 32, weight: .light))
                        .multilineTextAlignment(.center)
                }
                .frame(width: 320)
                .padding(.horizontal, 32)
                .matchedGeometryEffect(id: "pointers." + content.title, in: namespace)
            }
        }
        .padding(95)
        .foregroundStyle(.white)
    }
}
