//
//  CT_Globals.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 15/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices
import CoreAudioKit

func getFinishedAndStartedAtCrackTotemTimes() -> (finishedAt: Date?, startedAt: Date?) {
    
    return (ud.value(forKey: CT_UD_KEY_GAME_FINISHED) as? Date, ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date)
}

func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

/* 
func makeIphoneVibrate() { //probati za > iphone 7
    
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    generator.prepare()
    generator.impactOccurred()

}
*/

func convertOld(crackTotemSticker: CrackTotemSticker?) -> Totem? {
    guard let cts = crackTotemSticker else {return nil}
    
    return Totem.init(sid: cts.sid, name: cts.name, o: cts.getTotal_O(), t: cts.getTotal_P(), claimed: cts.claimed, sort: cts.sort)
}

func convert(crackTotemSticker: CrackTotemSticker?) -> Totem? {
    guard let cts = crackTotemSticker else {return nil}
    
    let done = cts.getTotal_O()
    let left = cts.getTotal_P() - done
    
    return Totem.init(sid: cts.sid, name: cts.name, o: done, t: left, claimed: cts.claimed, sort: cts.sort)
}
