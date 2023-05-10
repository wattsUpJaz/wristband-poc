//
//  WristbandPocApp.swift
//  WristbandPoc Watch App
//
//  Created by Jasmyne Carson on 5/6/23.
//

import SwiftUI

@main
struct WristbandPoc_Watch_AppApp: App {
    @StateObject var audioHapticManager = AudioHapticManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioHapticManager)
        }
    }
}
