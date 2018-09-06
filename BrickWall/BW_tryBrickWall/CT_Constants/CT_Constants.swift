//
//  CT_Constants.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 08/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//




import UIKit

struct CT_Constants {
    struct Values {
        struct BrickTap {
            static let regular: Int = 1
            static let hammerGain: Int = 10 // 500 //50
            static let hammerGainForQuizz: Int = 100
//        static let hammerGain: Int = 3000 // test za brzo rusenje zida..
        }
        struct CreditsWorthTaps {
            static let gold: Int = 1000//100 // 10000
            static let silver: Int = 100
        }
        struct Hammer {
            //static let toWait: TimeInterval = 10*60//3*60 // 5// 15 // 10 * 60 // [sec] // 10min//3 min
            static let toWait: TimeInterval = 30*60 // 5// 15 // 10 * 60 // [sec] // 10min//3
            //static let activeMaxPeriod: TimeInterval = 30 // 5 // 10 // 30 // [sec] // 100 je inace
            static let activeMaxPeriod: TimeInterval = 30 // 5 // 10 // 30 // [sec] // 100 je inace
        }
        struct SaveEvery {
            static let saveStateEvery_InTaps: Int = 10
        }
        struct CryptoKeys {
            static let secureKey = "i2IrXeIcecgIkHGKRsSr"
        }
    }
    struct Localization {
        static let CT_BUY_FOR = "Strings.CT.BricksBar.BuyFor.staticTxt" // treba Strings...
        static let CT_USE_HAMMER = "Strings.CT.BricksBar.useHammer" // treba Strings...
        static let CT_GAME_OVER_TITLE = "Strings.CT.BricksView.gameOver.title"
        static let CT_GAME_OVER_MSG = "Strings.CT.BricksView.gameOver.msg"
        static let CT_YOU_HAVE_THIS_STICKER = "Strings.CT.CrackTotems"
    }
    struct LocalKeys {
        static let ctGameStarts = "ctGameStarts"
        static let ctGameFinished = "ctGameFinished"
        static let ctCounterNumberSaved = "ctCounterNumberSaved"
        static let ctCounterUserClaimedHammerAt = "ctCounterUserClaimedHammerAt"
        static let ctGameFirstStarts = "ctGameFirstStarts"
        static let ctGameUserIsUsingHammer = "ctGameUserIsUsingHammer"
        
        static let getAllCrestWebReqFinishedSuccessfully = "getAllCrestWebReqFinishedSuccessfully"
        static let crackTotemStateReportedSuccessfully = "crackTotemStateReportedSuccessfully"
    }
    struct Colors {
        static let goldYellowBorder: UIColor = UIColor(red: 255/255, green: 214/255, blue: 98/255, alpha: 1.0)
        static let lightBlueBorder: UIColor = UIColor(red: 48/255, green: 216/255, blue: 204/255, alpha: 1.0)
        static let gray_51: UIColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        static let gray_43: UIColor = UIColor(red: 43/255, green: 43/255, blue: 43/255, alpha: 1.0)
        static let gray_73: UIColor = UIColor(red: 73/255, green: 73/255, blue: 73/255, alpha: 1.0)
    }
    
}

let CT_BRICK_TAP_VAL_GAIN = CT_Constants.Values.BrickTap.hammerGain
let CT_BRICK_TAP_VAL_REG = CT_Constants.Values.BrickTap.regular
let CT_BRICK_TAP_VAL_FOR_QUIZZ = CT_Constants.Values.BrickTap.hammerGainForQuizz

let CT_GOLD_WORTH_TAPS = CT_Constants.Values.CreditsWorthTaps.gold
let CT_SILVER_WORTH_TAPS = CT_Constants.Values.CreditsWorthTaps.silver

let CT_BUY_FOR = NSLocalizedString(CT_Constants.Localization.CT_BUY_FOR, comment: "")
let CT_USE_HAMMER = NSLocalizedString(CT_Constants.Localization.CT_USE_HAMMER, comment: "")

let CT_HAMMER_TO_WAIT = CT_Constants.Values.Hammer.toWait
let CT_HAMMER_ACTIVE_MAX_TIME = CT_Constants.Values.Hammer.activeMaxPeriod

let CT_SAVE_STATE_EVERY_IN_TAPS = CT_Constants.Values.SaveEvery.saveStateEvery_InTaps


let CT_UD_KEY_GAME_STARTS = CT_Constants.LocalKeys.ctGameStarts
let CT_UD_KEY_GAME_FINISHED = CT_Constants.LocalKeys.ctGameFinished
let CT_UD_KEY_COUNTER_NUM_SAVED = CT_Constants.LocalKeys.ctCounterNumberSaved
let CT_UD_KEY_USER_CLAIMED_HAMMER_AT = CT_Constants.LocalKeys.ctCounterUserClaimedHammerAt
let CT_UD_KEY_GAME_FIRST_STARTS = CT_Constants.LocalKeys.ctGameFirstStarts
let CT_UD_KEY_USER_IS_USING_HAMMER = CT_Constants.LocalKeys.ctGameUserIsUsingHammer

let CT_GAME_OVER_TITLE = NSLocalizedString(CT_Constants.Localization.CT_GAME_OVER_TITLE, comment: "")
let CT_GAME_OVER_MSG = NSLocalizedString(CT_Constants.Localization.CT_GAME_OVER_MSG, comment: "")
let CT_YOU_HAVE_THIS_STICKER = NSLocalizedString(CT_Constants.Localization.CT_YOU_HAVE_THIS_STICKER, comment: "")

let GAME_CRACK_TOTEM_DATA_DOWNLOADED_SUCCESSFULLY = CT_Constants.LocalKeys.getAllCrestWebReqFinishedSuccessfully
let GAME_CRACK_TOTEM_STATE_REPORTED_SUCCESSFULLY = CT_Constants.LocalKeys.crackTotemStateReportedSuccessfully

let CT_GAME_SECURE_KEY = CT_Constants.Values.CryptoKeys.secureKey

let CT_YELLOW_GOLD_COLOR = CT_Constants.Colors.goldYellowBorder
let CT_LIGHT_BLUE_COLOR = CT_Constants.Colors.lightBlueBorder
let CT_GRAY_51 = CT_Constants.Colors.gray_51
let CT_GRAY_43 = CT_Constants.Colors.gray_43
let CT_GRAY_73 = CT_Constants.Colors.gray_73
