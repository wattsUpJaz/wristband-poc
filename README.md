#  Stand Alone WatchOS Wristband - Proof of Concept

## How To Run
Connect an iPhone with a paired Apple Watch via USB to your computer, then select your device as the build target. A physical device is needed because haptics can't play on a simulator (duh).
Follow any prompting to unlock your phone or watch, trust your computer, restart your devices, etc.
Note: Althought this app only runs on the Apple Watch, a paired iPhone is needed to connect to the watch from XCode.

## Cons
Whenever a haptic is played a built-in sound is also played. It cannot be turned off (as far as I could find). You can put the watch in silent mode, but it will also silence the music, defeating the whole purpose. This is a limitation of a watchOS-only app, and could possibly be overcome by creating a watch app with a companion iPhone app that connects to bluetooth devices. Unfortunately, initial research into the latency with the companion iPhone app approach is not encouraging, and seems to be very high and unpredictable.

## Pros
Latency is very low when using the `addBoundaryTimeObserver` function to schedule the events at specific times in the playback.

## Differences between Complex and Simple Haptics
The simple haptics plays a strong vibration on every beat of the song's bpm.

The complex haptics essentially play as a second drum-track. This proved to be waaaay too complex for a user to really understand what the haptics were doing and the haptics felt mostly random to them.

I think a good haptic experience for a wristband would be something that establishes a really strong connection to some aspect of the song (like the kickdrum or the bpm). Once that relationship is strongly established, accents and emphasis can be added to different parts of the experience. However, without that strong relationship between the haptics and something in the song, the user will quickly lose context of what the haptics are suppose to mean.
