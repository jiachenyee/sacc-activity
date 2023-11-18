//
//  AddPointsView.swift
//  jiachen group fun
//
//  Created by Kai Quan Tay on 18/11/23.
//

import SwiftUI

struct AddPointsView: View {
    @Binding var groups: [ActivityGroup]

    @State private var pointsToAdd: [String: Int] = [:]

    @State private var filterByAdding: Bool = false

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                VStack {
                    ForEach(shownGroups, id: \.groupName) { group in
                        GroupBox {
                            HStack {
                                HStack {
                                    Text(group.groupName)
                                    Spacer()
                                    Text("\(group.points) Points")
                                }
                                .containerRelativeFrame(.horizontal, count: 5, span: 2, spacing: 0)
                                .padding(.trailing, 20)
                                HStack {
                                    TextField("", value: bindingPointsToAdd(for: group.groupName), formatter: pointsFormatter)
                                        .multilineTextAlignment(.leading)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())

                                    Button("+100") {
                                        withAnimation {
                                            add(points: 100, to: group.groupName)
                                        }
                                    }
                                }
                            }
                        }
                    }

                    if shownGroups.isEmpty {
                        ContentUnavailableView("No Groups", systemImage: "person.fill.questionmark")
                    }
                }
            }

            Divider()

            Button {
                withAnimation {
                    groups = groups.map { addingPoints(to: $0) }
                    pointsToAdd = [:]
                    filterByAdding = false
                }
            } label: {
                HStack {
                    Text("Add Points to ^[\(pointsToAdd.values.filter({ $0 != 0 }).count) Group](inflect: true)")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(20)
        .toolbar {
            Button {
                filterByAdding.toggle()
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle" + (filterByAdding ? ".fill" : ""))
            }
        }
    }

    var shownGroups: [ActivityGroup] {
        guard filterByAdding else { return groups }

        return groups.filter {
            (pointsToAdd[$0.groupName] ?? 0) != 0
        }
    }

    var pointsFormatter: some Formatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }

    func bindingPointsToAdd(for groupName: String) -> Binding<Int> {
        .init {
            pointsToAdd[groupName] ?? 0
        } set: { newValue in
            pointsToAdd[groupName] = newValue
        }
    }

    func add(points: Int, to groupName: String) {
        pointsToAdd[groupName] = (pointsToAdd[groupName] ?? 0) + points
    }

    func addingPoints(to group: ActivityGroup) -> ActivityGroup {
        var mutableGroup = group
        mutableGroup.points += (pointsToAdd[group.groupName] ?? 0)

        return mutableGroup
    }
}

#Preview {
    AddPointsView(groups: .constant((1...9).map {
        ActivityGroup(groupName: "Group \($0)", points: .random(in: 1...40) * 100)
    }))
}
