//
//  ReviewPresentationGroupView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct ReviewPresentationGroupView: View {
    
    var submissions: [Submission]
    var groupIndex: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 21)
                .stroke(lineWidth: 5)
                .opacity(0.2)
            Text("GROUP \(groupIndex)")
                .font(.system(size: 30))
                .padding(4)
                .background(.black)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: -20)
            
            if let submission = submissions.first(where: {
                String($0.activityGroup.groupName.split(separator: " ").last ?? "") == String(groupIndex)
            }) {
                switch submission.contents {
                case .flag:
                    if let flagURL = submission.activityGroup.flagURL {
                        AsyncImage(url: flagURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .padding()
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Text("No Submission")
                            .font(.system(size: 32))
                            .foregroundStyle(.white.opacity(0.7))
                    }
                case .text(let string):
                    Text(string)
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 32))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .foregroundStyle(.white)
                }
            } else {
                Text("No Submission")
                    .font(.system(size: 32))
                    .foregroundStyle(.white.opacity(0.7))
            }
        }
        .frame(width: 534, height: 254)
    }
}
