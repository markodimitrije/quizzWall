//
//  SoundManager.swift
//  evdhjshcx
//
//  Created by Dragan Krtalic on 16/02/2017.
//  Copyright © 2017 Dragan Krtalic. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager: NSObject {
    
    // IMPLEMENT ME!!! mora bolji code jer init moze da FAIL i na bundle resource i na AVAudioPlayer
    
    var bgMusicPlayer: AVAudioPlayer
    
    var audioPlayer: AVAudioPlayer
    
    var ud: UserDefaults {
        return UserDefaults.standard
    }
    
    override init() {
        
//        print("SoundManager is called to be INITIALIZED !")
        
//         interna func: posaljes jos AVAudioPlayer property, da nasetuje za zadati fajl iz Bundle resource
//         trebalo bi da bude failable - kako ?
        func setMyAudioProperty(forResource resource: String) -> AVAudioPlayer? {
            
            var player: AVAudioPlayer?
            
            if let myUrl = Bundle.main.url(forResource: resource, withExtension: "wav") {
                
                do {
                    player = try AVAudioPlayer(contentsOf: myUrl)
                } catch {
                    print(error)
                }
            }
            
            return player
            
        }
        
        bgMusicPlayer = AVAudioPlayer()
        audioPlayer = AVAudioPlayer()
        
        if let player = setMyAudioProperty(forResource: "bgMusic") {
            
            bgMusicPlayer = player
            
        }
        
        if let player = setMyAudioProperty(forResource: "stickerPlacedIntoAlbum_Miss") {
            
            audioPlayer = player
            
        }
        
        super.init()
        
//        print("SoundManager is INITIALIZED")
        
    }
    
    fileprivate var soundInfo: [SoundMessage: String] { // ove poruke zna da pretvori u zvuk
        return [
            
            .appIsGettingActivePlayBgMusic: "bgMusic",
            
            .stickerPlacedIntoAlbum_Miss: "stickerPlacedIntoAlbum_Miss",
            .stickerPlacedIntoAlbum_Regular: "stickerPlacedIntoAlbum_Regular",
            .stickerPlacedIntoAlbum_FullPage: "stickerPlacedIntoAlbum_FullPage",
            .stickerPlacedIntoAlbum_FullTeam: "stickerPlacedIntoAlbum_FullTeam",
            .stickerPlacedIntoAlbum_FullAlbum: "stickerPlacedIntoAlbum_FullAlbum",
            .albumTurnPage: "albumTurnPage",
            .albumTurnPageNoMorePages: "stickerPlacedIntoAlbum_Miss", // melodija vec imamo...
            .stickerTappedFromAlbum: "stickerTappedFromAlbum",
            .emptyCardTapped: "emptyCardTapped",
            .teamTappedFromAlbumTable: "teamTappedFromAlbumTable",

            .stickerTappedFromStickers: "stickerTappedFromStickers",
            .teamTappedFromStickersTable: "teamTappedFromStickersTable",
            
            .isScrollingOnTeamsAtTable: "isScrollingOnTeamsAtTable",
            
            .isScrollingFromStickersStream: "isScrollingFromStickersStream",
            
            .swipingThroughZoomedStickers: "swipingThroughZoomedStickers",
            
            .isListingBags: "isListingBags",
            .bagSelected: "bagSelected",
            
            .isScrollingAtOffersTable: "isScrollingAtOffersTable",
            .sendOffer_Success: "sendOffer_Success",
            .sendOffer_Fail: "sendOffer_Fail",
            
            .isScrollingFromFriends: "isScrollingFromFriends",
            .sendFriendRequest_Success: "sendFriendRequest_Success",
            .sendFriendRequest_Fail: "sendFriendRequest_Fail",
            .userGotNewFriend: "userGotNewFriend",
            .userGotNewFriendRequest: "userGotNewFriendRequest",
            
            .userGotNewGameRequest: "userGotNewFriendRequest", // ista je melodija kao za f_req
            
            .profilePictureUploaded_Success: "profilePictureUploaded_Success",
            .profilePictureUploaded_Fail: "profilePictureUploaded_Fail",
            
            .flippingStickers: "flippingStickers",
            .newStickerReceived: "newStickerReceived",
            .newStickersReceived: "newStickersReceived",
            .duplicateReceived: "duplicateReceived",
            .duplicatesReceived: "duplicatesReceived",
            
            .timeForFreeBag: "timeForFreeBag",
            
            .offerReceived: "offerReceived",
            .friendRequestReceived: "friendRequestReceived",
            .friendReceived: "friendReceived",
            .stickersReceived: "stickersReceived",
            .notificationReceived: "notificationReceived",
            
            .multipleUpdatesFromWeb: "multipleUpdatesFromWeb",
            
            .setSticker: "teamTappedFromStickersTable", // ista je melodija kao za 'izabrao neki team'
            .setActiveField: "newStickerReceived", // ista je melodija kao za 'dobio novu slicicu'
            .guessNotYourTurn: "emptyCardTapped", // ista je melodija kao za 'tap na emptyCard'
            .guessAlreadyPlayedField: "stickerPlacedIntoAlbum_Miss", // ista je melodija kao za 'promasio lepljenje'
            .guessMiss: "duplicateReceived", // ista je melodija kao za 'dobio duplikat'
            .guessWin: "stickerPlacedIntoAlbum_FullAlbum", // ista je melodija kao za
            .gameOver: "stickerPlacedIntoAlbum_FullAlbum", // ista je melodija kao za 'popunio album'
            
            .lwPrizeWinCoins: "lwPrizeWinCoins",
            .lwPrizeWinStickers: "lwPrizeWinStickers",
            .lwPrizeLoseStake: "lwPrizeLoseStake",
            .lwPinBounce: "lwPinBounce",
            .lwWheelBadSwipeSlowOrWrongDirection: "stickerPlacedIntoAlbum_Miss", // melodija vec imamo...
            .lwWheelBadSwipeToFast: "emptyCardTapped", // melodija vec imamo...
            .lwStakeFlies: "teamTappedFromStickersTable", // melodija vec imamo...
            
            .bwTapRegular: "", // HC treba NEW
            .bwTapStrong: "", // HC treba NEW
            .bwHammerBecameAvailable: "BW_hammer_available",
            .bwBrickCracked: "BW_new_crack",
            .bwBrickFinished: "BW_brick_destroyed",
            .bwGameFinished: "stickerPlacedIntoAlbum_FullAlbum" // melodija vec imamo...
        ]
    }
    
    // MARK:- Interface
    
    func playSound(_ msg: Any?) {
        
        //print("SoundManager.playSound IS CALLED")
        
        guard let msg = msg as? SoundMessage else { // ako ti je poruka poznata
            
//            print("playSound.err: can't read sound msg"); 
            return
            
        }
        
        if msg == .appIsGettingActivePlayBgMusic {
            
            //print("SoundManager.playSound: msg is .appIsGettingActivePlayBgMusic")
            
            if audioIsAllowed(forKey: SETTING_KEY_MUSIC_SWITCH) {
                
                playBgMusic(msg)
                
            }
            
        } else {
            
            //print("SoundManager.playSound: msg is NOT .appIsGettingActivePlayBgMusic")
            
            if audioIsAllowed(forKey: SETTING_KEY_SOUNDS_SWITCH) {
                
                playKnownSound(msg) // zovi private koja reprodukuje poznatu poruku
                
            }
            
        }
        
    }
    
    func appIsGettingInactive() { // javice ti AppDelegate
        
        removeAllSoundsAndMusic()
        
    }
    
    func lwIsGettingInactive() { // javice ti lwVC
        
//        print("lwIsGettingInactive is CALLED")
        
        audioPlayer.stop()
        
    }
    
    fileprivate func playKnownSound(_ msg: SoundMessage) {
        
        //[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil HACK :)
        
        do {
            try AVAudioSession.sharedInstance().setCategory("AVAudioSessionCategoryPlayback")
        } catch {
//            print("SoundManager.playKnownSound.error: can't create AVAudioSession object.")
        }
        
        guard let audioFileName = soundInfo[msg] else {
        
//            print("err.SoundManager.playKnownSound.g-else: no audio file name");
            return
        
        }
        
        if let myAudioUrl = Bundle.main.url(forResource: audioFileName, withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: myAudioUrl)
                audioPlayer.volume = getAudioVolume(msg)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch let error as NSError {
                print("playKnownSound = \(error.localizedDescription)")
            }
        }
        
    }
    
    fileprivate func playBgMusic(_ msg: SoundMessage) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory("AVAudioSessionCategoryPlayback")
        } catch {
            print("SoundManager.playBgMusic.catch: can't create AVAudioSession object.")
        }
        
        guard let audioFileName = soundInfo[msg] else {
            
//            print("err.SoundManager.playBgMusic: no audio file name");
            return
            
        }
        
        if let myAudioUrl = Bundle.main.url(forResource: audioFileName, withExtension: "wav"),
            !bgMusicPlayer.isPlaying {
            
            do {
                bgMusicPlayer = try AVAudioPlayer(contentsOf: myAudioUrl)
                bgMusicPlayer.volume = getAudioVolume(msg)
                bgMusicPlayer.numberOfLoops = Int.max
                bgMusicPlayer.prepareToPlay()
                bgMusicPlayer.play()
            } catch let error as NSError {
                print("playBgMusic.catch = \(error.localizedDescription)")
            }
            
        }
        
    }
    
    fileprivate func audioIsAllowed(forKey key: String) -> Bool {
        
        // ovde zoves svoje Settings i vidis da li je omogucen zvuk, da li prekidac ON
        
        //print("SoundManager.audioIsAllowed is CALLED for key: \(key)")
        
        guard let allowed = ud.value(forKey: key) as? Bool else {
            
            //print("err.SoundManager.audioIsAllowed: ne mogu da procitam NSUserDefaults")
            
            return false
            
        }
        
        //print("audioIsAllowed.status, za \(key) vracam: \(allowed)")
        
        return allowed // fall-back
        
    }
    
    fileprivate func getAudioVolume(_ msg: SoundMessage) -> Float {
        
        // dacemo svakoj melodiji istu jacinu: (ili vrednost iz Settings ili const: 0.5)
        
        if msg == .appIsGettingActivePlayBgMusic {
            
            return ud.value(forKey: SETTING_KEY_MUSIC_LEVEL) as? Float ?? 0.5
            
        } else {
            
            return ud.value(forKey: SETTING_KEY_SOUNDS_LEVEL) as? Float ?? 0.5
            
        }
        
    }
    
    // Privates
    
    func removeAllSoundsAndMusic() {
        
//        print("SoundManager.removeAllSoundsAndMusic is CALLED")
        
        bgMusicPlayer.stop()
        audioPlayer.stop()
        
    }
    
}
