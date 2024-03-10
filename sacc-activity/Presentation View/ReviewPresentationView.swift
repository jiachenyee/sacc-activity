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
        "twisties",
        "pizza",
        "mad-developers",
        "mewing-dabys",
        "fried-chicken",
        "ipear"
    ]
    
    let afternoonGroups = [
        "i-dont-know",
        "noted-with-thanks",
        "john",
        "bob-the-builder",
        "anything-ah-anything",
        "half-functional"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 64) {
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "twisties")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "pizza")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "mad-developers")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "mewing-dabys")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "fried-chicken")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "ipear")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "i-dont-know")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "noted-with-thanks")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "john")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "bob-the-builder")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "anything-ah-anything")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "half-functional")
                }
            }
            .padding(95)
        }
    }
}
