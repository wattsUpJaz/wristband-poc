//
//  ContentView.swift
//  WristbandPoc Watch App
//
//  Created by Jasmyne Carson on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var audioHapticsManager: AudioHapticManager
    
    @State private var isPaused = true
    
    var body: some View {
        VStack {
            Image(systemName:
                audioHapticsManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.accentColor)
                .onTapGesture {
                    isPaused = !isPaused
                    audioHapticsManager.playPause()
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioHapticManager())
    }
}
