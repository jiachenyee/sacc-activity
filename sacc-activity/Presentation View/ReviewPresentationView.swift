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
        "1AM",
        "2AM",
        "3AM",
        "4AM",
        "5AM",
        "6AM",
        "7AM",
        "8AM"
    ]
    
    let afternoonGroups = [
        "1PM",
        "2PM",
        "3PM",
        "4PM",
        "5PM",
        "6PM",
        "7PM",
        "8PM"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 64) {
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "1AM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "2AM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "3AM")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "4AM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "5AM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "6AM")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "7AM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "8AM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "1PM")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "2PM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "3PM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "4PM")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "5PM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "6PM")
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "7PM")
                }
                HStack(spacing: 64) {
                    ReviewPresentationGroupView(activity: activity, submissions: submissions, groupName: "8PM")
                    Spacer()
                }
            }
            .padding(95)
        }
    }
}
