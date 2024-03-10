//
//  ReviewPresentationGroupView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI
import Algorithms

struct ReviewPresentationGroupView: View {
    
    var activity: String
    
    var submissions: [Submission]
    var groupName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 21)
                .stroke(lineWidth: 5)
                .opacity(0.2)
            
            if let submission = submissions.last(where: {
                $0.activity == activity && $0.activityGroup.groupName == groupName
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
                            
                            Text("\(score) songs")
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
                            
                        Text(label)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .font(.system(size: 18, weight: .light))
                            .padding(16)
                            .background(.thickMaterial)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 21))
                }
            } else {
                Text("No Submission")
                    .font(.system(size: 32))
                    .foregroundStyle(.white.opacity(0.7))
            }
            
            Text(groupName.uppercased())
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

let songsList = [
    "both of us",
    "birch",
    "renegade",
    "two is better than one",
    "you'll always find your way back home",
    "bein' with my baby",
    "gasoline",
    "this is what you came for",
    "hold on",
    "best days of your life",
    "big star",
    "better man",
    "half of my heart",
    "highway don't care",
    "1 step forward, 3 steps back",
    "deja vu",
    "the joker and the queen",
    "babe",
    "the 1",
    "22",
    "afterglow",
    "the albatross",
    "the alchemy",
    "all of the girls you loved before",
    "all too well",
    "all you had to do was stay",
    "american girl",
    "anti-hero",
    "the archer",
    "august",
    "babe",
    "baby",
    "back to december",
    "bad blood",
    "bad blood",
    "beautiful eyes",
    "beautiful ghosts",
    "begin again",
    "bejeweled",
    "the best day",
    "bette davis eyes",
    "better man",
    "better than revenge",
    "betty",
    "bigger than the whole sky",
    "the black dog",
    "blank space",
    "the bolter",
    "breathe",
    "breathless",
    "but daddy i love him",
    "bye bye baby",
    "call it what you want",
    "cardigan",
    "carolina",
    "champagne problems",
    "change",
    "christmas must be something more",
    "christmas tree farm",
    "christmases when you were mine",
    "clara bow",
    "clean",
    "closure",
    "cold as you",
    "come back... be here",
    "come in with the rain",
    "cornelia street",
    "cowboy like me",
    "crazier",
    "cruel summer",
    "dancing with our hands tied",
    "daylight",
    "dear john",
    "death by a thousand cuts",
    "delicate",
    "don't blame me",
    "don't you",
    "dorothea",
    "down bad",
    "dress",
    "drops of jupiter",
    "enchanted",
    "end game",
    "epiphany",
    "everything has changed",
    "exile",
    "eyes open",
    "false god",
    "fearless",
    "fifteen",
    "forever & always",
    "forever winter",
    "fresh out the slammer",
    "getaway car",
    "girl at home",
    "gold rush",
    "gorgeous",
    "guilty as sin?",
    "happiness",
    "haunted",
    "hey stephen",
    "hits different",
    "hoax",
    "holy ground",
    "how you get the girl",
    "i almost do",
    "i bet you think about me",
    "i can do it with a broken heart",
    "i can fix him (no really i can)",
    "i did something bad",
    "i forgot that you existed",
    "i heart ?",
    "i knew you were trouble",
    "i know places",
    "i think he knows",
    "i want you back",
    "i wish you would",
    "if this was a movie",
    "illicit affairs",
    "i'm only me when i'm with you",
    "innocent",
    "invisible",
    "invisible string",
    "is it over now?",
    "it's nice to have a friend",
    "it's time to go",
    "ivy",
    "jump then fall",
    "karma",
    "king of my heart",
    "labyrinth",
    "the lakes",
    "last christmas",
    "the last great american dynasty",
    "last kiss",
    "the last time",
    "lavender haze",
    "loml",
    "london boy",
    "long live",
    "long live",
    "long story short",
    "look what you made me do",
    "love story",
    "lover",
    "lover",
    "the lucky one",
    "macavity",
    "mad woman",
    "the man",
    "the manuscript",
    "marjorie",
    "maroon",
    "mary's song",
    "mastermind",
    "me!",
    "mean",
    "message in a bottle",
    "midnight rain",
    "mine",
    "mirrorball",
    "miss americana & the heartbreak prince",
    "the moment i knew",
    "mr. perfectly fine",
    "my boy only breaks his favorite toys",
    "my tears ricochet",
    "never grow up",
    "new romantics",
    "new year's day",
    "nothing new",
    "now that we don't talk",
    "only the young",
    "the other side of the door",
    "our song",
    "ours",
    "out of the woods",
    "the outside",
    "paper rings",
    "peace",
    "a perfectly good heart",
    "picture to burn",
    "a place in this world",
    "question...?",
    "...ready for it?",
    "red",
    "right where you left me",
    "ronan",
    "run",
    "sad beautiful tragic",
    "safe & sound",
    "santa baby",
    "say don't go",
    "september",
    "seven",
    "shake it off",
    "should've said no",
    "silent night",
    "slut!'",
    "the smallest man who ever lived",
    "so it goes...",
    "so long, london",
    "soon you'll get better",
    "sparks fly",
    "speak now",
    "starlight",
    "state of grace",
    "stay beautiful",
    "stay stay stay",
    "the story of us",
    "style",
    "suburban legends",
    "superman",
    "superstar",
    "sweet nothing",
    "sweeter than fiction",
    "teardrops on my guitar",
    "tell me why",
    "that's when",
    "this is me trying",
    "this is why we can't have nice things",
    "this love",
    "tied together with a smile",
    "tim mcgraw",
    "tis the damn season",
    "today was a fairytale",
    "tolerate it",
    "the tortured poets department",
    "treacherous",
    "umbrella",
    "untouchable",
    "the very first night",
    "vigilante shit",
    "the way i loved you",
    "we are never ever getting back together",
    "welcome to new york",
    "we were happy",
    "white christmas",
    "white horse",
    "who's afraid of little old me?",
    "wildest dreams",
    "willow",
    "wonderland",
    "you are in love",
    "you belong with me",
    "you need to calm down",
    "you're losing me",
    "you're not sorry",
    "you're on your own, kid",
    "evermore",
    "no body, no crime",
    "snow on the beach",
    "snow on the beach",
    "you all over me",
    "coney island",
    "all too well",
    "dear reader",
    "foolish one",
    "glitch",
    "the great war",
    "high infidelity",
    "i can see you",
    "paris",
    "timeless",
    "when emma falls in love",
    "would've, could've, should've",
    "electric touch",
    "castles crumbling",
    "karma",
    "the alcott",
    "i don't wanna live forever"
]

func scoreAppIdea(with appIdea: String) -> (String, Int) {
    var allWords = Array(Set(songsList.map {
        $0.filter { char in
            char.isLetter || char.isNumber || char.isWhitespace
        }
    }))
    
    var score = 0
    
    var index = 0
    
    var splitAppIdea = appIdea.components(separatedBy: .whitespacesAndNewlines)
    
    while index < splitAppIdea.count {
        print("index", index)
        print(splitAppIdea.joined(separator: " "))
        let word = splitAppIdea[index]
        print(word)
        let preprocessedWord = word.lowercased().filter { char in
            char.isLetter || char.isNumber || char.isWhitespace
        }
        
        let potentialOptions = songsList.filter { song in
            preprocessedWord.components(separatedBy: " ").first == song.components(separatedBy: " ").first!
        }
        
        print(potentialOptions)
        
        guard !potentialOptions.isEmpty else {
            index += 1
            continue
        }
        
        for option in potentialOptions {
            let optionWords = option.components(separatedBy: .whitespacesAndNewlines)
            
            print(splitAppIdea.count)
            guard splitAppIdea.count - index > optionWords.count - 1 else {
                continue
            }
            
            let potentialMatch = Array(splitAppIdea[index...(index + optionWords.count - 1)]).joined(separator: " ").lowercased().filter { char in
                char.isLetter || char.isNumber || char.isWhitespace
            }
            
            if potentialMatch == optionWords.joined(separator: " ").lowercased() {
                splitAppIdea[index] = "*" + splitAppIdea[index]
                
                print("INDEX", index + optionWords.count - 1)
                splitAppIdea[index + optionWords.count - 1] = splitAppIdea[index + optionWords.count - 1] + "*"
                score += 1
                
                index += optionWords.count - 1
            }
        }
        
        index += 1
    }
    
    return (splitAppIdea.joined(separator: " "), score)
}

//func highlightAndCountOccurances(of phrase: String, in string: String) -> (modifiedString: String, count: Int) {
//    var modifiedString = string
//    let regexSafePhrase = NSRegularExpression.escapedPattern(for: phrase)
//    
//    let pattern = regexSafePhrase.reduce("") { partialResult, character in
//        "\(partialResult)(?:(?!\\w).)*\(character)"
//    }
//    
//    do {
//        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
//        let matches = regex.matches(in: string, options: [], range: NSRange(string.startIndex..., in: string))
//        
//        var adjustment = 0
//        for match in matches.reversed() {
//            let range = Range(match.range, in: string)!
//            let start = string.index(range.lowerBound, offsetBy: adjustment)
//            let end = string.index(range.upperBound, offsetBy: adjustment)
//            let matchedString = String(string[start..<end])
//            let highlighted = "**\(matchedString)**"
//            modifiedString = modifiedString.replacingCharacters(in: start..<end, with: highlighted)
//            adjustment += 4
//        }
//        
//        return (modifiedString, matches.count)
//    } catch {
//        print("Invalid regular expression")
//        return (string, 0)
//    }
//    
//    return (modifiedString, count)
//}
