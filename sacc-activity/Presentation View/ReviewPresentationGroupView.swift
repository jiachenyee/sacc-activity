//
//  ReviewPresentationGroupView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct ReviewPresentationGroupView: View {
    
    var activity: String
    
    var submissions: [Submission]
    var groupIndex: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 21)
                .stroke(lineWidth: 5)
                .opacity(0.2)
            
            if let submission = submissions.last(where: {
                $0.activity == activity && String($0.activityGroup.groupName.split(separator: " ").last ?? "") == String(groupIndex)
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
                    if activity == "idea" {
                        VStack {
                            let (appIdea, score) = scoreAppIdea(with: string)
                            
                            ScrollView {
                                Text(try! AttributedString(markdown: appIdea))
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 32))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundStyle(.white)
                            }
                            
                            Text("\(score) words")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .font(.system(size: 18, weight: .light))
                        }
                        .padding(32)
                    } else {
                        VStack {
                            Text(string)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 32))
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .foregroundStyle(.white)
                        }
                        .padding(32)
                    }
                case .triviaSubmission(let submission, let label):
                    VStack {
                        Text(submission)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 32))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .foregroundStyle(.white)
                        
                        Text(label)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 18, weight: .light))
                    }
                    .padding(32)
                case .triviaMap(let location, let label):
                    ZStack(alignment: .bottomTrailing) {
                        MapWithPinView(coordinate: location)
                            .clipShape(RoundedRectangle(cornerRadius: 21))
                        Text(label)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 18, weight: .light))
                            .padding(32)
                            .background(.thickMaterial)
                    }
                }
            } else {
                Text("No Submission")
                    .font(.system(size: 32))
                    .foregroundStyle(.white.opacity(0.7))
            }
            
            Text("GROUP \(groupIndex)")
                .font(.system(size: 30))
                .padding(4)
                .background(.black)
                .frame(maxHeight: .infinity, alignment: .top)
                .offset(y: -20)
                .zIndex(100)
        }
        .frame(width: 534, height: 254)
    }
}

let wordsList = [
    ["Academy", "Academies", "Academic", "Academically"],
    ["Apple", "Apples"],
    ["Ballet", "Ballets", "Balletomane"],
    ["Battery", "Batteries"],
    ["Bolt", "Bolts", "Bolting", "Bolted"],
    ["Boss", "Bosses", "Bossy", "Bossing"],
    ["Box", "Boxes", "Boxed", "Boxing", "Boxful", "Boxlike", "Boxer"],
    ["Bubble", "Bubbles", "Bubbled", "Bubbling", "Bubbly"],
    ["Cake", "Cakes", "Caking", "Caked"],
    ["Camera", "Cameras"],
    ["Cook", "Cooks", "Cooking", "Cooked", "Cookery", "Cookout"],
    ["Cheese", "Cheeses", "Cheesy"],
    ["Cloud", "Clouds", "Cloudy", "Clouding", "Clouded"],
    ["Coconut", "Coconuts"],
    ["Crocodile", "Crocodiles"],
    ["Cutlery", "Cutleries"],
    ["Deliver", "Delivers", "Delivered", "Delivering", "Delivery"],
    ["Domino", "Dominos"],
    ["Duck", "Ducks", "Ducking", "Ducked"],
    ["Exact", "Exacts", "Exacting", "Exacted", "Exactly"],
    ["Fly", "Flies", "Flying", "Flew", "Flown", "Flyer"],
    ["Fry", "Fries", "Frying", "Fried", "Fryer"],
    ["Gas", "Gases", "Gassing", "Gassed"],
    ["Grandma", "Grandmas", "Grandmother", "Grandmama"],
    ["Jacket", "Jackets", "Jacketed"],
    ["Key", "Keys", "Keying", "Keyed", "Keycard", "Keyless"],
    ["Laugh", "Laughs", "Laughing", "Laughed", "Laughter"],
    ["Leave", "Leaves", "Leaving", "Left", "Leaver"],
    ["Light", "Lights", "Lighting", "Lighted", "Lit", "Lighter"],
    ["Lucky", "Luckier", "Luckiest", "Luckily", "Luck"],
    ["Marker", "Markers", "Marking", "Marked", "Mark"],
    ["Ocean", "Oceans", "Oceanic", "Oceanography"],
    ["Onion", "Onions"],
    ["Plain", "Plains", "Plainer", "Plainest", "Plainly", "Plainness", "Airplane"],
    ["Rain", "Rains", "Rained", "Raining", "Rainy"],
    ["Recycle", "Recycles", "Recycling", "Recycled"],
    ["Reduce", "Reduces", "Reducing", "Reduced"],
    ["Rest", "Rests", "Resting", "Rested"],
    ["Reuse", "Reuses", "Reusing", "Resed"],
    ["Scan", "Scans", "Scanning", "Scanned", "Scanner"],
    ["Slay", "Slays", "Slaying", "Slew", "Slain"],
    ["Spin", "Spins", "Spinning", "Spun"],
    ["Stack", "Stacks", "Stacking", "Stacked", "Stacker"],
    ["Stone", "Stones", "Stoning", "Stoned"],
    ["Swim", "Swims", "Swimming", "Swam", "Swum"],
    ["Tank", "Tanks", "Tanking", "Tanked", "Tanker"],
    ["Tape", "Tapes", "Taping", "Taped"],
    ["Tinker", "Tinkers", "Tinkering", "Tinkered", "Tinkerer", "Tinkerers"],
    ["Tissue", "Tissues"],
    ["Viola", "Violas"]
]

func scoreAppIdea(with appIdea: String) -> (String, Int) {
    var allWords = wordsList.flatMap { $0.map { $0.lowercased() } }
    
    var finalAppIdea = appIdea
    
    var score = 0
    
    for word in appIdea.components(separatedBy: .whitespacesAndNewlines.union(.punctuationCharacters).union(.symbols)) {
        if let wordIndex = allWords.firstIndex(of: word.lowercased()) {
            finalAppIdea = finalAppIdea.replacingOccurrences(of: word, with: "**" + word + "**")
            allWords.remove(at: wordIndex)
            score += 1
        }
    }
    
    return (finalAppIdea, score)
}
