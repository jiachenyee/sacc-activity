//
//  TriviaPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct TriviaPresentationView: View {
    
    var duration: TimeInterval
    var title: String
    var questionNumber: Int
    var image: NSImage?
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var timeElapsed: TimeInterval = 0
    
    @State private var minutes = "00"
    @State private var seconds = "00"
    
    @State private var timesUp = false
    
    var body: some View {
        VStack {
            if timesUp {
                Text("Time’s Up!")
                    .foregroundStyle(.yellow)
                    .font(.system(size: 48))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                HStack(spacing: 0) {
                    Text("\(minutes):\(seconds)")
                        .contentTransition(.numericText())
                        .monospacedDigit()
                        .font(.system(size: 32))
                        .padding(.trailing, 32)
                    
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(.white.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        Rectangle()
                            .fill(.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: (timeElapsed / duration) * geometry.size.width)
                    }
                }
                .frame(height: 32)
                .padding([.top], 32)
            }
            
            if !timesUp {
                Spacer()
                
                Text(title)
                    .font(.system(size: 100, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                if let image {
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding([.bottom, .horizontal], 32)
                }
                
                Spacer()
                
                Text("Use `/q\(questionNumber)` to submit your answer.")
                    .font(.system(size: 36, weight: .regular))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(95)
        .onReceive(timer) { _ in
            timeElapsed += 0.1
            display(timeRemaining: duration - timeElapsed)
        }
    }
    
    func display(timeRemaining: TimeInterval) {
        let minutesReading = Int(floor(timeRemaining / 60))
        let secondsReading = Int(timeRemaining.truncatingRemainder(dividingBy: 60))
        
        withAnimation(.spring()) {
            if minutesReading <= 9 {
                minutes = "0\(minutesReading)"
            } else {
                minutes = "\(minutesReading)"
            }
            
            if secondsReading <= 9 {
                seconds = "0\(secondsReading)"
            } else {
                seconds = "\(secondsReading)"
            }
        }
        
        if timeRemaining <= 0 && !timesUp {
            withAnimation {
                timesUp = true
            }
        }
    }
}

#Preview {
    TriviaPresentationView(duration: 30, title: "", questionNumber: 1)
}
