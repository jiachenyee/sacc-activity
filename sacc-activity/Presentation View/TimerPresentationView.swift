//
//  TimerPresentationView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 17/11/23.
//

import SwiftUI

struct TimerPresentationView: View {
    
    var namespace: Namespace.ID
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var timerInput: TimerInput
    
    @State private var timeElapsed: TimeInterval = 0
    
    @State private var minutes = "00"
    @State private var seconds = "00"
    
    @State private var timesUp = false
    
    var timeInterval: Double {
        abs((timerInput.startDate ?? .now).timeIntervalSince(timerInput.endDate))
    }
    
    var body: some View {
        ZStack {
            switch timerInput.content {
            case .wordsList:
                Text("Use `/idea` to submit your team’s app idea")
                    .font(.system(size: 80, weight: .medium))
                    .multilineTextAlignment(.center)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 95)
                
                WordsPresentationView()
                    .scaleEffect(0.7, anchor: .top)
                    .padding(.top, 300)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .clipped()
                    .frame(width: 1920, height: 1080)
            case .pointers(let array):
                PointersPresentationView(namespace: namespace, contents: array)
                    .frame(maxHeight: .infinity)
                    .padding(.bottom, 95 + 32)
            }
            
            VStack(spacing: 0) {
                Spacer()
                
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
                                .frame(width: (timeElapsed / timeInterval) * geometry.size.width)
                        }
                    }
                    .frame(height: 32)
                    .padding([.top], 32)
                    .padding([.horizontal, .bottom], 95)
                }
            }
        }
        .onReceive(timer) { _ in
            timeElapsed += 0.1
            display(timeRemaining: timeInterval - timeElapsed)
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
