//
//  Stopwatch.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 13/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation
import QuartzCore

class BW_TimerManager {
    
    enum CT_CounterEvent {
        case userEnterTheGame
        case userLeft
        case userClaimedHammer
    }
    
    var ctCounterEventInfo: [CT_CounterEvent: String] = [.userEnterTheGame:CT_UD_KEY_GAME_STARTS,
        .userLeft: CT_UD_KEY_GAME_FINISHED,
        .userClaimedHammer: CT_UD_KEY_USER_CLAIMED_HAMMER_AT]
    
    var value: TimeInterval = 0
    let timeToWaitOnHammer = CT_HAMMER_TO_WAIT
    let timeToUseHammer = CT_HAMMER_ACTIVE_MAX_TIME
    var timeToWaitAndUseHammer: TimeInterval {
        return timeToWaitOnHammer + timeToUseHammer
    }
    
    var startingPoint: Date? // napunice te func recreateState(timer:......
    
    var now: Date {
        return Date.init(timeIntervalSinceNow: 0)
    }
    var lastTimeHammerClaimedAt: Date? {
        return getLastSavedTime(event: .userClaimedHammer)
    }
    var userLeftAt: Date? {
        return getLastSavedTime(event: .userLeft)
    }
    var userEnterTheGameAt: Date? {
        return getLastSavedTime(event: .userEnterTheGame)
    }
    
    
    var t_now : CFTimeInterval {
        return CACurrentMediaTime()
    }
    var t_lastTimeHammerClaimedAt : CFTimeInterval? {
        return lastTimeHammerClaimedAt?.timeIntervalSinceNow
    }
    var t_userLeftAt : CFTimeInterval? {
        return userLeftAt?.timeIntervalSinceNow
    }
    var t_userEnterTheGameAt : CFTimeInterval? {
        return userEnterTheGameAt?.timeIntervalSinceNow
    }
    
    
    weak var delegate: BrickWallVC?
    
    // MARK:- API
    
    func saveState() {
        
        func checkAgainsFirstStart(startedAt: Date) {
            
            if let _ = ud.value(forKey: CT_UD_KEY_GAME_FIRST_STARTS) as? Date {
                // ako imas upisanu vrednost, nikom nista
            } else {
                ud.set(startedAt, forKey: CT_UD_KEY_GAME_FIRST_STARTS)
            }
            
        }
        
        let now = NSDate.init(timeIntervalSinceNow: 0) as Date
        
        // REFACTOR ovo u 1 objekat ! + napravi func koja moze da moj random objekat pretvara u JSON i to save u U.D. (generic)
        
        ud.set(now, forKey: CT_UD_KEY_GAME_FINISHED)
//        print("saveState.CT_UD_KEY_GAME_FINISHED = \(now)")
        
        var val: TimeInterval = 0
        
        if let finishedAt = ud.value(forKey: CT_UD_KEY_GAME_FINISHED) as? Date,
            let startedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date {
                val = abs(finishedAt.timeIntervalSince(startedAt))
            
            checkAgainsFirstStart(startedAt: startedAt)
            
        }
        
        ud.set(val, forKey: CT_UD_KEY_COUNTER_NUM_SAVED)
//        print("saveState.val = \(val)")
        
    }
    
    // zapamti kod sebe VAR VALUE na osnovu vremena now i ud.lastSaved
    // a timer koji ti je poslat ako je NIL onda load-uj novim
    
    func recreateState(timer: inout Timer?) {
        
        if timer == nil {
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: delegate!, selector: #selector(BrickWallVC.updateClock), userInfo: nil, repeats: true)
        }
        
    }
    
    // in: trazice ti neko sta da prikaze
    // out: ti prikazi vrednost u zavisnosti od svojih VARs ili vrati NIL ako ne treba da prikaze
    
    func getCounterValue() -> String? {
        
        guard let counter = getTimerValue() else { return nil }
        
        let res = getFormatedCounter(forValue: counter)
        
        if counter == 0 {
            
            if let _ = delegate?.isHammerActive() {
                
                //print("COUNTER JE ISTEKAO ZA GAIN !")
                
                return res
                
            } else {
                
                timeElapsedWaitingForHammer()
                
                let v = counter != -1 ? res : CT_USE_HAMMER
                
                return v
            }
        }
        
        let v = counter < 0 ? CT_USE_HAMMER : res
        
        return v
    }

    
    func getTimerValue() -> Int? {
        
        //da li meris vreme za dobijanje HAMMER-a ili vreme dok koristi HAMMER ?
        
        guard let userIsUsingHammer = delegate?.isHammerActive() else {
//            print("getTimerValue.userIsUsingHammer: NE ZNAM !?!??! ")
            return nil
        }
        
        if userIsUsingHammer {
         
            let val = calculateTimerValueForUsingHammer()
//            print("koristi hammer, vracam: \(String(describing: val))")
            
            return val
            
        } else {
            
            let val = calculateTimerValueForWaitingOnHammer()
//            print("CEKAM hammer, vracam: \(String(describing: val))")
            
            if val == 0 {
                delegate?.hammerBecameAvailable()
            }
            
            return val
            
        }
        
    }
    
    func isUserUsingHammer() -> Bool {
        guard let claimedAt = ud.value(forKey: CT_UD_KEY_USER_CLAIMED_HAMMER_AT) as? Date else {
            return false
        }
        
        let timePassed = abs(now.timeIntervalSince(claimedAt))
        
        return 1 + timePassed < timeToUseHammer
        
    }
    
    private func calculateTimerValueForWaitingOnHammer() -> Int? {
        
        guard let startedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date else { return nil }
        
        // proveri slucaj da li je prvi put usao u igricu (u zivotu)
        guard let _ = ud.value(forKey: CT_UD_KEY_GAME_FINISHED) as? Date else {
            // vrati full odbrojavanje
            
            guard let lastClaimedAt = ud.value(forKey: CT_UD_KEY_USER_CLAIMED_HAMMER_AT) as? Date else {
            
                let val = timeToWaitOnHammer - now.timeIntervalSince(startedAt)
                
                return Int.init(round(val))
                
            }
            
            let val = (timeToWaitOnHammer + timeToUseHammer) - now.timeIntervalSince(lastClaimedAt)
            
            return Int.init(round(val))
            
        }
        
        // sledeci deo se odnosi da je do sada imao barem 1 finishedAt i 2 startAt-a:
        
        if let lastClaimedAt = ud.value(forKey: CT_UD_KEY_USER_CLAIMED_HAMMER_AT) as? Date {
            if now.timeIntervalSince(lastClaimedAt) < now.timeIntervalSince(startedAt) {
                let v = timeToWaitAndUseHammer - now.timeIntervalSince(lastClaimedAt)
                return Int.init(round(v))
            }
        }
        
        return checkAgainstNoClaimedBetweenStartedAt()
        
    }
    
    private func checkAgainstNoClaimedBetweenStartedAt() -> Int? {
        
        guard let startedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date else { return nil }
        
        let dynamicDiff = abs(now.timeIntervalSince(startedAt))
        
        guard let firstSavedStartedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date,
            let lastSavedStartedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date else {
                return nil
        }
        let earlierTime = abs(lastSavedStartedAt.timeIntervalSince(firstSavedStartedAt))
        
        let val = timeToWaitOnHammer - earlierTime - dynamicDiff
        
        if val < 0 { return -1 }
    
        return Int.init(round(val))
        
    }
    
    private func calculateTimerValueForUsingHammer() -> Int? {
        
        guard let claimedAt = ud.value(forKey: CT_UD_KEY_USER_CLAIMED_HAMMER_AT) as? Date else {
            return nil
        }
        
        let time = max(timeToUseHammer - abs(now.timeIntervalSince(claimedAt)),0)
        
        return Int.init(time)
        
    }
    
    
    // MARK:- javljaju ti drugi dogadjaje:
    
    func viewDidAppear() {
        // local func 1
        func saveNewStartedAt() {
            let now = Date.init(timeIntervalSinceNow: 0)
            ud.set(now, forKey: CT_UD_KEY_GAME_STARTS)
//            print("TimerManager.viewDidAppeard = \(now)")
        }
        // local func 2
        func updateEarnedWaitForHammer(val: TimeInterval) {
            
            ud.set(val, forKey: CT_UD_KEY_COUNTER_NUM_SAVED) // update
            
        }
        
        // sacuvaj novi startedAt samo ako si prosao ceo interval timeToWaitOnHammer
        
        guard let lastStartedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date else { // (**)
            saveNewStartedAt() // (**) ovo je prvi put u zivotu da si usao u CrackTotemGame
            return
        }
        
        // ako ne bi bilo 'IF' update bi ga uvek i ne bi sabirao pojedinacna cekanja za hammer
        
        let offlineTime = abs(lastStartedAt.timeIntervalSince(now))
        
        let onlineTimeSum = ud.value(forKey: CT_UD_KEY_COUNTER_NUM_SAVED) as? TimeInterval ?? 0
        
        if offlineTime + onlineTimeSum > timeToWaitOnHammer {
            //saveNewStartedAt()
            updateEarnedWaitForHammer(val: 0)
        }
        
    }
    
    func userSuccessfullyClaimedHammer() {

        ud.set(now, forKey: CT_UD_KEY_USER_CLAIMED_HAMMER_AT)
        ud.set(true, forKey: CT_UD_KEY_USER_IS_USING_HAMMER)
        
    }
    
    private func timeElapsedForUsingHammer() {
//        print("timeElapsedForUsingHammer is CALLED")
        ud.set(nil, forKey: CT_UD_KEY_USER_CLAIMED_HAMMER_AT)
        ud.set(false, forKey: CT_UD_KEY_USER_IS_USING_HAMMER)
    }
    
    private func timeElapsedWaitingForHammer() {
//        print("timeElapsedWaitingForHammer is CALLED")
        delegate?.playSound(.bwHammerBecameAvailable)
    }
    
    // MARK: - calculate (deo API-ja)
    
    private func checkAgainstBeingInTheGameBefore(startedAt: Date, lastExit: Date) -> String? {
        
        // ovde ima sav info lastExit i createdAt + zapamceno koliko je cekao na kom statusu
        
        let timeSpentOutsideCT_Game = abs(lastExit.timeIntervalSince(startedAt))
        
        let savedFromBefore = ud.value(forKey: CT_UD_KEY_COUNTER_NUM_SAVED) as? TimeInterval ?? 0
        
        if timeSpentOutsideCT_Game + savedFromBefore > timeToWaitOnHammer { // savedFromBefore je vreme koje je 'odcekao'
            return CT_USE_HAMMER
        } else {
            
            let dynamicDiff = abs(now.timeIntervalSince(startedAt))
            
            guard let firstSavedStartedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date,
                let lastSavedStartedAt = ud.value(forKey: CT_UD_KEY_GAME_STARTS) as? Date else {
                    return ""
            }
            let earlierTime = abs(lastSavedStartedAt.timeIntervalSince(firstSavedStartedAt))
            
            let val = timeToWaitOnHammer - earlierTime - dynamicDiff
            
            if val < 0 { return CT_USE_HAMMER }
            
//            print("CT_Stopwatch.checkAgainstBeingInTheGameBefore.startedAt = \(startedAt)")
            
            return "\(Int.init(val))"
            
        }
        
    }
    
    private func getLastSavedTime() -> Date {
        
        let now = NSDate.init(timeIntervalSinceNow: 0) as Date
        var lastSavedTime: Date!
        
        if let remembered = ud.value(forKey: CT_UD_KEY_GAME_FINISHED) as? Date {
            
            lastSavedTime = remembered // OK
            
        } else { //print("recreateState.cant read DATE from UserDefaults")
            
            lastSavedTime = now // BACK-UP SOLUTION
            ud.set(now, forKey: CT_UD_KEY_GAME_FINISHED)
        }
        
        return lastSavedTime
        
    }
    
    // za trazeni kljuc, funkcija uzima podatak iz U.D. (prethodno treba da si zapamtio...)
    
    private func getLastSavedTime(event: CT_CounterEvent) -> Date? {
        
        guard ctCounterEventInfo.keys.contains(event) else { return nil }
        
        return ud.value(forKey: ctCounterEventInfo[event]!) as? Date
        
    }
    
}



extension BW_TimerManager: HammerViewCounterFormating {

    func getFormatedCounter(forValue value: Int) -> String {
        
        if value >= 0 {
            let (_,m,s) = secondsToHoursMinutesSeconds(seconds: value)
            return "\(m)m \(s)s"
        } else {
//            print("HammerViewCounterFormating.getFormatedCounter = vracam TEXT")
            return CT_USE_HAMMER
        }
        
    }
    
}
