//
//  GlobalsTemp.swift
//  tryJustBrickWallVC
//
//  Created by Marko Dimitrijevic on 28/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

let ud = UserDefaults.standard
let AG_ASSET_GOLD_COST = 10
let token: String? = "1234"

// SETTINGS_KEYS

let SETTING_KEY_MUSIC_SWITCH = "music_switch"
let SETTING_KEY_MUSIC_LEVEL = "music_level"
let SETTING_KEY_SOUNDS_SWITCH = "sounds_switch"
let SETTING_KEY_SOUNDS_LEVEL = "sounds_level"

let SETTING_KEY_ALLOW_FRI_SUGG = "allowFriendSuggestions"

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let email: String? = "marko_dimitrije@gmail.com"



var soundMan = SoundManager()

var appDel: AppDelegate! { return UIApplication.shared.delegate as! AppDelegate }

