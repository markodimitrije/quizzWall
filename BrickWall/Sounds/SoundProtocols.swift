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
//
//}
//
//extension PlayingSound where Self: FriendRequestManager {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([
//                    .sendFriendRequest_Fail,
//                    .sendFriendRequest_Success
//                    ])
//    }
//
//}
//
//extension PlayingSound where Self: MainVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([
//                .teamTappedFromAlbumTable,
//                .albumTurnPage,
//                .albumTurnPageNoMorePages
//                ])
//    }
//
//}
//
//extension PlayingSound where Self: StickersTableVC { // imamo AlbumTableVC: StickersTableVC
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ SoundMessage.isScrollingOnTeamsAtTable,
//                    SoundMessage.teamTappedFromStickersTable
//            ])
//    }
//
//}
//
//extension PlayingSound where Self: OffersTableVC { // scroll na tabeli sa ponudama
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ SoundMessage.isScrollingAtOffersTable ])
//    }
//
//}
//
//// OFF_REPLACE+
//extension PlayingSound where Self: OffersTableVC_NI { // scroll na tabeli sa ponudama
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ SoundMessage.isScrollingAtOffersTable ])
//    }
//
//}
//
////extension PlayingSound where Self: SelectableStreamVC { // imam problem zbog nasledjivanja
//
//extension PlayingSound where Self: UnselectableStreamVC { // scroll na tabeli sa ponudama
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ SoundMessage.isScrollingFromStickersStream,
//                    SoundMessage.stickerTappedFromStickers
//                    ])
//    }
//
//}
//
//extension PlayingSound where Self: MatesStreamVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ SoundMessage.isScrollingFromFriends ])
//    }
//
//}
//
////extension PlayingSound where Self: MatesTableVC {
////
////    func knownSoundSet() -> Set<SoundMessage> {
////
////        return Set([ SoundMessage.isScrollingFromFriends ])
////    }
////
////}
//
//extension PlayingSound where Self: TM_FromStickers {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ SoundMessage.stickerPlacedIntoAlbum_Miss,
//                    SoundMessage.stickerPlacedIntoAlbum_Regular,
//                    SoundMessage.stickerPlacedIntoAlbum_FullPage,
//                    SoundMessage.stickerPlacedIntoAlbum_FullTeam,
//                    SoundMessage.stickerPlacedIntoAlbum_FullAlbum
//                    ])
//    }
//
//}
//
//
//extension PlayingSound where Self: NewPackVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .newStickerReceived,
//                    .duplicateReceived
//            ])
//    }
//
//}
//
//extension PlayingSound where Self: Synchronization {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .friendReceived,
//            .friendRequestReceived,
//            .offerReceived,
//            .stickersReceived,
//            .notificationReceived,
//            .multipleUpdatesFromWeb
//            ])
//    }
//
//}
//
//extension PlayingSound where Self: SingleStickerVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .swipingThroughZoomedStickers ])
//    }
//
//}
//
//extension PlayingSound where Self: AlbumStreamVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .stickerTappedFromAlbum, .emptyCardTapped ])
//    }
//
//}
//
//extension PlayingSound where Self: ListNewBagsCVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .isListingBags, .bagSelected ])
//    }
//
//}
//
//extension PlayingSound where Self: ListNewBagsVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .isListingBags, .bagSelected ])
//    }
//
//}
//
//extension PlayingSound where Self: BuyStickersVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .timeForFreeBag ])
//    }
//
//}
//
//extension PlayingSound where Self: MainViewController {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .timeForFreeBag ])
//    }
//
//}
//
//// tap_game se sound manage-uje iz 2 klase
//
//extension PlayingSound where Self: TapkeVCImprovedForStickers {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([.setSticker,
//                    .setActiveField ]) // nije sjajno ovde !
//
//    }
//
//}
//
//extension PlayingSound where Self: TapkeGameAnimationManager {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([.guessMiss,
//                    .guessWin,
//                    .gameOver ])
//
//    }
//
//}
//
//extension PlayingSound where Self: TapkeGameNotificationManager {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([.guessNotYourTurn,
//                    .guessAlreadyPlayedField ])
//
//    }
//
//}
//
//
//
//extension PlayingSound where Self: AppDelegate {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .timeForFreeBag,
//                     .appIsGettingActivePlayBgMusic ])
//    }
//
//    func appIsGettingActive() { // javice ti AppDelegate, a ti utvrdi da li je bgMusic: enabled
//
////        print("SoundProtocols.appIsGettingActive is CALLED")
//
//        if let bgMusicSwitch = ud.value(forKey: SETTING_KEY_MUSIC_SWITCH) as? Bool { // ovaj key imas u HeavyDownloading, treba neki refactoring da bude u klasi AppSettings npr
//
//            if bgMusicSwitch {
////                print("bgMusicSwitch.PUSTI ZVUK !!!")
//                playSound(.appIsGettingActivePlayBgMusic)
//            } else {
////                print("bgMusicSwitch.NEMA MUZIKE !!!")
//                //soundMan.removeAllSoundsAndMusic() // ako je nesto 'zaostalo' TRY OFF
//            }
//
//        }
//
//    }
//
//    func appIsGettingInactive() { // javice ti AppDelegate, a ti ugasi music i sound
//
//        //print("SoundProtocols.appIsGettingInactive is CALLED")
//
//        soundMan.appIsGettingInactive()
//
//    }
//
//
//
//}
//
//extension PlayingSound where Self: LuckyWheelVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .lwPrizeWinCoins,
//                     .lwPrizeWinStickers,
//                     .lwPrizeLoseStake,
//                     .lwPinBounce,
//                     .lwWheelBadSwipeSlowOrWrongDirection,
//                     .lwWheelBadSwipeToFast
//            ])
//
//    }
//
//}
//
//extension PlayingSound where Self: DuplicatesCVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .lwStakeFlies,
//                     .stickerPlacedIntoAlbum_Miss
//                    ])
//
//    }
//
//}
//
//extension PlayingSound where Self: CoinsCVC {
//
//    func knownSoundSet() -> Set<SoundMessage> {
//
//        return Set([ .lwStakeFlies,
//                     .stickerPlacedIntoAlbum_Miss
//                    ])
//
//    }
//
//}
//
//
//
//
//
//
//
