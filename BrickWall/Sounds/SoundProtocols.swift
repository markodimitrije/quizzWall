//
//  Protocols.swift
//  StickersApp
//
//  Created by Dragan Krtalic on 17/02/2017.
//  Copyright © 2017 Dragan Krtalic. All rights reserved.
//

import Foundation

protocol PlayingSound {
    
    func knownSoundSet() -> Set<SoundMessage>
    
    func playSound(_ msg: SoundMessage)
    
}

extension PlayingSound {
    
    func playSound(_ msg: SoundMessage) {
        
        if knownSoundSet().contains(msg) {
            
            soundMan.playSound(msg)
            
        } else {
            
//            print("can't play send because it is not sent from allowed place")
            
        }
         
    }
    
}

extension PlayingSound where Self: BrickWallVC {
    
    func knownSoundSet() -> Set<SoundMessage> {
        
        return Set([ .bwTapRegular, .bwTapStrong, .bwHammerBecameAvailable,
                     .bwBrickCracked, .bwBrickFinished, .bwGameFinished ])
    }
    
}
