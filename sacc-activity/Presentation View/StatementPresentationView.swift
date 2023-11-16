//
//  StatementPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct StatementPresentationView: View {
    
    var statement: String
    
    var body: some View {
        Text(try! AttributedString(markdown: statement))
            .font(.system(size: 100, weight: .regular))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    StatementPresentationView(statement: "Statement")
}
