//
//  ReviewPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct ReviewPresentationView: View {
    
    var activity: String
    var submissions: [Submission]
    
    var body: some View {
        VStack(spacing: 64) {
            HStack(spacing: 64) {
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 1)
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 2)
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 3)
            }
            HStack(spacing: 64) {
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 4)
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 5)
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 6)
            }
            HStack(spacing: 64) {
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 7)
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 8)
                ReviewPresentationGroupView(activity: activity, submissions: submissions, groupIndex: 9)
            }
        }
        .padding(95)
    }
}
