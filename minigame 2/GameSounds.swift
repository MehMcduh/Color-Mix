//
//  GameSounds.swift
//  Color Mix
//
//  Created by Bui Thu Ha on 4/7/17.
//  Copyright © 2017 HI Entertainment. All rights reserved.
//

import AVFoundation


class GameSounds: NSObject, AVAudioPlayerDelegate {
    
    static let sharedInstance = GameSounds()
    var audioPlayer : AVAudioPlayer?
    // muting music
    let musicMuteKey = "musicMuted"
    private(set) var musicIsMuted = false
    // muting sound
    let soundMuteKey = "soundMuted"
    private(set) var soundIsMuted = false

    
    private override init() {
        let defaults = UserDefaults.standard
        musicIsMuted = defaults.bool(forKey: musicMuteKey)
        soundIsMuted = defaults.bool(forKey: soundMuteKey)
    }
    
    public func playBackgroundMusic() {
        if !musicIsMuted && (audioPlayer == nil || audioPlayer?.isPlaying == false) {
        let gameMusicURL = NSURL(fileURLWithPath: Bundle.main.path(forResource: "game music", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:gameMusicURL as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
        } catch {
            print("Cannot play the file")
        }
        }
        else {
                print("Audio player is already playing!")
            }
    }
    
   func toggleMuteMusic() -> Bool {
        musicIsMuted = !musicIsMuted
        
        let defaults = UserDefaults.standard
        defaults.set(musicIsMuted, forKey: musicMuteKey)
        defaults.synchronize()
        if musicIsMuted {
            audioPlayer?.stop()
        } else {
            playBackgroundMusic()
        }
        return musicIsMuted
    }

    func toggleMuteSound() -> Bool {
        soundIsMuted = !soundIsMuted
        
        let defaults = UserDefaults.standard
        defaults.set(soundIsMuted, forKey: soundMuteKey)
        defaults.synchronize()
        return soundIsMuted
    }

    

    
    


}
