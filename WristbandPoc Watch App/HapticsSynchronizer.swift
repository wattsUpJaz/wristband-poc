//
//  HapticsSynchronizer.swift
//  WristbandPoc Watch App
//
//  Created by Jasmyne Carson on 5/8/23.
//

import Foundation
import AVFoundation
import WatchKit

/// Handles syncing haptics to the audio that is configured to the provided AVPlayer
class HapticsSynchronizer : NSObject {
    private let player: AVPlayer
    private let hapticEvents: [HapticEvent]

    init(player: AVPlayer, hapticEvents: [HapticEvent]) {
        self.player = player
        self.hapticEvents = hapticEvents
    }
    
    /// Sync all HapticEvents in hapticEvents to audio
    func startSynchronization() {
        for event in hapticEvents {
            let timeValue = NSValue(time: event.timeInterval)
            
            player.addBoundaryTimeObserver(forTimes: [timeValue], queue: .main) { [weak self] in
                if let hapticType = event.hapticType {
                    WKInterfaceDevice.current().play(hapticType)
                }
            }
        }
    }
    
    /// Directly sync haptic events to audio without first converting the data to an array of HapticEvents objects. This is more optimized, because the haptics can be set as a batch instead of as one at a time.
    func addBatchHapticTimeObservers(times: [NSValue], hapticType: WKHapticType) {
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
                WKInterfaceDevice.current().play(hapticType)
            }
    }

}
