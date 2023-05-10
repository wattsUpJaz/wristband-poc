//
//  AudioHapticManager.swift
//  WristbandPoc Watch App
//
//  Created by Jasmyne Carson on 5/8/23.
//

import Foundation
import AVFoundation
import WatchKit

/// Manages playing the audio and syncing the haptics to the audio. Also creates the data that describes the haptic experiences.
final class AudioHapticManager : ObservableObject {
    var player: AVPlayer
    @Published private(set) var isPlaying: Bool = false
    
    ///  Determines whether to play the complicated or simple haptic experience
    ///  Change to true to experience complicated haptic patterns
    private let isComplexHaptics : Bool = false
    
    private let startingBeatTime : TimeInterval = 0.175
    private let beat : TimeInterval = 0.4 // calculation = 60 (seconds) / 150 (bpm)
    
    init () {
        // set up player
        let url = Bundle.main.url(forResource: "You & Me - Flume Remix", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)

        // set up haptics
        if isComplexHaptics {
            let hapticEvents = generateComplexHapticsPatterns()
            let hapticsSynchronizer = HapticsSynchronizer(player: player, hapticEvents: hapticEvents)
            hapticsSynchronizer.startSynchronization()
        } else {
            let hapticsSynchronizer = HapticsSynchronizer(player: player, hapticEvents: [])
            setBaselineHapticBeat(hapticsSynchronizer: hapticsSynchronizer)
        }
    }
    
    /// Sets baseline haptics that establish the pulse of the song.
    func setBaselineHapticBeat(hapticsSynchronizer: HapticsSynchronizer) {
        let startRange = 0...200
        let startBaselineHapticsTimes = startRange.map { beat -> NSValue in
            return NSValue(time: getCmTimeFromBeat(beatNum: Double(beat)))
        }
        hapticsSynchronizer.addBatchHapticTimeObservers(times: startBaselineHapticsTimes, hapticType: .start)

    }
    
    private func generateComplexHapticsPatterns() -> [HapticEvent] {
        var hapticEvents : [HapticEvent] = []
        // click haptic
        hapticEvents.append(contentsOf: createEvents(beats: [9.0,13.0,17.0,19.0,25.0,26.0,27.0,28.0], hapticType: WKHapticType.success))
        // start haptic (more firm click)
        hapticEvents.append(contentsOf: createEvents(beats: [21.0, 23.0,29.0,30.0,31.0,32.0], hapticType: WKHapticType.start))
        // success haptic (up triple beat)
        hapticEvents.append(contentsOf: createEvents(beats: [33.0], hapticType: WKHapticType.success))
        // uncategorized haptic
        hapticEvents.append(contentsOf: createEvents(beats: [
            // at 14.7s
            37.0,39.0,40.0,40.5,41.0,45.0,47.0,48.0,
            // at 21.5
            48.5,49.0,50.5,51.0,52.5,53.0,54.5,55.0,55.5,56.0,56.5,57.0,
            // at 22.5s (mostly a repeat of above pattern)
            58.5,59.0,60.5,61.0,62.5,63.0,63.5,64.0,64.5,65.0], hapticType: WKHapticType.success))
        
        return hapticEvents
    }
    
    func playPause() {
        
        if player.timeControlStatus == .playing {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    private func createEvents(beats: [Double], hapticType: WKHapticType) -> [HapticEvent] {
        var hapticEvents : [HapticEvent] = []
        for i in beats {
            hapticEvents.append(HapticEvent(timeInterval: getCmTimeFromBeat(beatNum: i),hapticType: hapticType))
        }
        return hapticEvents
    }
    
    private func getCmTimeFromBeat(beatNum: Double) -> CMTime {
        return CMTime(seconds: (startingBeatTime + beat*(beatNum-1.0)), preferredTimescale: 1000)
    }
}
