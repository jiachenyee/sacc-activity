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
        if statement.count > 300 {
            Text(try! AttributedString(markdown: statement))
                .font(.system(size: 36, weight: .light))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(100)
        } else {
            Text(try! AttributedString(markdown: statement))
                .font(.system(size: 100, weight: .regular))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    StatementPresentationView(statement: "Statement")
}
