//
//  ContentView.swift
//  sacc-activity
//
//  Created by Jia Chen Yee on 13/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var discordManager = DiscordManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
