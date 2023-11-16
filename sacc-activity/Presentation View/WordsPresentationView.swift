//
//  WordsPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI
import Algorithms

let words = ["Academy", "Apple", "Ballet", "Battery", "Bolt", "Boss", "Box", "Bubble", "Cake", "Camera", "Cook", "Cheese", "Cloud", "Coconut", "Crocodile", "Cutlery", "Deliver", "Domino", "Duck", "Exact", "Fly", "Fry", "Gas", "Grandma", "Jacket", "Key", "Laugh", "Leave", "Light", "Lucky", "Marker", "Ocean", "Onion", "Plain", "Rain", "Recycle", "Reduce", "Rest", "Reuse", "Scan", "Slay", "Spin", "Stack", "Stone", "Swim", "Tank", "Tape", "Tinker", "Tissue", "Viola"]
    .chunks(ofCount: 5).map { [String]($0) }

struct WordsPresentationView: View {
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<10, id: \.self) { rowNumber in
                let rowWords = words[rowNumber]
                
                HStack(spacing: 0) {
                    ForEach(0..<5, id: \.self) { columnNumber in
                        Text(rowWords[columnNumber])
                            .font(.system(size: 80))
                            .frame(width: 346)
                    }
                }
                .frame(width: 89)
            }
        }
    }
}

#Preview {
    WordsPresentationView()
}
