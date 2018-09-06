//
//  ModelTypes.swift
//  evdhjshcx
//
//  Created by Dragan Krtalic on 16/02/2017.
//  Copyright © 2017 Dragan Krtalic. All rights reserved.
//

import Foundation

enum SoundMessage { // ovo su poruke za koje obj tipa SoundManager zna da reprodukuje audio
    
    // SENDER:
    
    // AppDelegate
    
    case appIsGettingActivePlayBgMusic // treba da pokrene bgMusic
    
    // album related msgs:
    case stickerPlacedIntoAlbum_Miss
    case stickerPlacedIntoAlbum_Regular
    case stickerPlacedIntoAlbum_FullPage
    case stickerPlacedIntoAlbum_FullTeam
    case stickerPlacedIntoAlbum_FullAlbum
    case albumTurnPage
    case albumTurnPageNoMorePages
    case stickerTappedFromAlbum
    case emptyCardTapped
    case teamTappedFromAlbumTable
    
    // stickers related msgs:
    case stickerTappedFromStickers
    case teamTappedFromStickers // scroll slicice
    case teamTappedFromStickersTable // scroll timove
    
    // album and stickers related:
    case isScrollingOnTeamsAtTable // called by StickersTableVC and AlbumTableVC
    
    // stickers and offers related:
    case isScrollingFromStickersStream // called by Unselectable and Selectable StreamVC
    
    // zoom sticker related
    case swipingThroughZoomedStickers
    
    // list new bags related
    case isListingBags
    case bagSelected
    
    // offers related msgs:
    case isScrollingAtOffersTable
    case sendOffer_Success
    case sendOffer_Fail
    
    // friends related msgs:
    case isScrollingFromFriends
    case sendFriendRequest_Success
    case sendFriendRequest_Fail
    case userGotNewFriend
    case userGotNewFriendRequest
    
    // game requests related msgs:
    case userGotNewGameRequest
    
    // profile related
    case profilePictureUploaded_Success
    case profilePictureUploaded_Fail
    
    // new pack related
    case flippingStickers
    case newStickerReceived
    case newStickersReceived
    case duplicateReceived
    case duplicatesReceived
    
    // category, buyStickers related
    case timeForFreeBag
    
    // RECEIVER:
    case stickersReceived
    case offerReceived
    case friendRequestReceived
    case friendReceived
    case notificationReceived
    
    case multipleUpdatesFromWeb
    
    // tap_game:
    case setSticker
    case setActiveField
    case guessMiss
    case guessWin
    case guessNotYourTurn
    case guessAlreadyPlayedField
    case gameOver
    
    // luckyWheel_game:
    case lwPrizeWinCoins
    case lwPrizeWinStickers
    case lwPrizeLoseStake
    case lwPinBounce
    case lwWheelBadSwipeSlowOrWrongDirection
    case lwWheelBadSwipeToFast
    case lwStakeFlies
    
    // crackTotem-brickWall
    case bwTapRegular
    case bwTapStrong
    case bwHammerBecameAvailable
    case bwBrickCracked
    case bwBrickFinished
    case bwGameFinished
}

