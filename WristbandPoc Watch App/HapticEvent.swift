//
//  HapticEvent.swift
//  WristbandPoc Watch App
//
//  Created by Jasmyne Carson on 5/8/23.
//

import WatchKit
import AVFoundation

/// The scruture used to describe haptic events on the watch
struct HapticEvent {
    let timeInterval: CMTime
    let hapticType: WKHapticType?
    
    init(timeInterval: CMTime, hapticType: WKHapticType? = .click) {
        self.timeInterval = timeInterval
        self.hapticType = hapticType
    }
}

