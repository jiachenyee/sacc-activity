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
    
    let morningGroups = [
        "1am",
        "2am",
        "3am",
        "4am",
        "5am",
        "6am",
        "7am",
        "8am"
    ]
    
    let afternoonGroups = [
        "1pm",
        "2pm",
        "3pm",
        "4pm",
        "5pm",
        "6pm",
        "7pm",
        "8pm"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 64) {
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "1am")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "2am")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "3am")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "4am")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "5am")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "6am")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "7am")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "8am")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "1pm")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "2pm")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "3pm")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "4pm")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "5pm")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "6pm")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "7pm")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "8pm")
                    Spacer()
                }
            }
            .padding(95)
        }
    }
}
