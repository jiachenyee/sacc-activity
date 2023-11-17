//
//  ReviewPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct ReviewPresentationView: View {
    
    var submissions: [Submission]
    
    var body: some View {
        VStack(spacing: 64) {
            HStack(spacing: 64) {
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 1)
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 2)
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 3)
            }
            HStack(spacing: 64) {
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 4)
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 5)
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 6)
            }
            HStack(spacing: 64) {
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 7)
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 8)
                ReviewPresentationGroupView(submissions: submissions, groupIndex: 9)
            }
        }
        .padding(95)
    }
}
