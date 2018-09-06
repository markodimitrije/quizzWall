//
//  CT_Protocols_2.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 12/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

protocol BrickBarManaging: class {
    func getCoinTypeForBuyingTotem() -> CoinType
    func gameIsFinished()
}

extension BrickBarManaging {
    func getCoinTypeForBuyingTotem() -> CoinType {
//        print("BrickBarManaging.getCoinTypeForBuyingTotem/ implement me")
        return CoinType.gold
    }
    func gameIsFinished() {
//        print("BrickBarManaging.gameIsFinished/ implement me")
    }
}





//protocol BtnTapManaging: class { PAZI !! koristis na CR_OFF_Protocols_1.swift - mesas projects !
//    func btnTapped(sender: UIButton)
//}

protocol BuyTotemAndHammerBtnTapManaging: BtnTapManaging {
    func isHammerAvailable() -> Bool?
}

extension BtnTapManaging where Self: BrickWallVC {
    func btnTapped(sender: UIButton) {
//        print("BtnTapManaging.btnTapped: sender.tag = \(sender.tag)")
    }
}

extension BuyTotemAndHammerBtnTapManaging {
    func isHammerAvailable() -> Bool? {
//        print("HammerBtnTapManaging.isHammerAvailable: implement me")
        return false
    }
}

extension BuyTotemAndHammerBtnTapManaging where Self: BrickWallVC {
    
    func isHammerAvailable() -> Bool? {
        
        guard let user = user else {return nil}
        return user.hammer > CT_BRICK_TAP_VAL_FOR_QUIZZ
        
    }
    
    func btnTapped(sender: UIButton) {
        
        switch sender.tag {
            
        case 0: userTappedBuyTotemBtn() // znam sa storyboard-a da je ovo buyTotemBtn
            
        case 20: userTappedGameOverView()
            
        default: break
        }
        
    }
    
    // MARK:- Private - process na btn tapped:
    
    private func userTappedBuyTotemBtn() {
        
//        print("userTappedBuyTotemBtn.prikazi alert sa bice ova funkc u sled release")
        
    }
    
    private func userTappedGameOverView() {
        
        bwGameOverView.isHidden = true
        
    }
    
}






protocol HammerViewCounterFormating {
    func getFormatedCounter(forValue value: Int) -> String
}

extension HammerViewCounterFormating {
    func getFormatedCounter(forValue value: Int) -> String {
//        print("getFormatedCounter.implement me")
        return "\(value)"
    }
}



protocol SaveToModelManaging: class {
    func appIsGoingToBg()
}

protocol CrackTotemSaveStateManaging: SaveToModelManaging {
    func modelStateIsChanged()
}


extension SaveToModelManaging {
    func appIsGoingToBg() {
//        print("SaveToModelManaging.appIsGoingToBg: implement me")
    }
    func userQuitGame() {
//        print("SaveToModelManaging.userQuitGame: implement me")
    }
}

extension CrackTotemSaveStateManaging {
    func modelStateIsChanged() {
//        print("SaveToModelManaging.modelStateIsChanged: implement me")
    }
}

extension CrackTotemSaveStateManaging where Self: BrickWallVC {
    
    fileprivate func saveStateImidiatelly() {
        
        /*
        let bgc = appDel.persistentContainer.newBackgroundContext()
        
        bgc.performAndWait { [weak self] in
            
            guard let strongSelf = self else { return }
        
            let freq: NSFetchRequest<CDCrackTotem> = CDCrackTotem.fetchRequest()
            var cts: CDCrackTotem?
            do {
                let structures = try bgc.fetch(freq)
                cts = structures.first
            } catch {
                print("saveStateImidiatelly.catch nisam prosao fetch za CTS")
            }

            cts?.updateStickerTotemToCoreData(totem: strongSelf.totem, ctx: bgc)
            
        }
        
        tryToSaveInContext(ctx: bgc)
        */
        
        //writeToJsonInBundle(totem: _totem)
        
        saveTotemToBundle()
        
        print("implement me, save data u bundle !!")
        
    }
    
    // ako je claimed po tvojim podacima, onda ne treba da javljas web-u i da prethodno stanje pamtis u svojoj coreData
    func userQuitGame() {
        
        if totem == nil { return }
        let sid = totem!.sid
        
        func update() {
            
            saveStateImidiatelly()
            
            gameIsBecomingInactive(sid: sid) // ima preko protocol_2 -> javi web-u
 
        }
        
        // ako igra nije gotova ! - pitaj svoju CD!
        
        /* now off
        
        guard let claimed = CDCrackTotem.isStickerClaimed(sid: sid) else { // int err
            update()
            return
        }
        
        */
        
        // pitaj svoj model koji zna da li je ovaj sid placed == true ili placed == false
        
        let claimed = false // hard-coded
        
        if !claimed { update() }// ako nije zaradio, update-uj svoj model, javi web-u itd..
        
    }
    
    func appIsGoingToBg() {
//        print("CrackTotemSaveStateManaging.appIsGoingToBg is CALLED")
        saveStateImidiatelly()
        
        self.gameIsBecomingInactive(sid: totem!.sid) // javi web-u
    }
    
    func modelStateIsChanged() {
        
        guard let totalScore = totem?.getScore() else { return }
        
        if totalScore % CT_SAVE_STATE_EVERY_IN_TAPS == 0 {
//            print(" % 100 je ispunjen, zovi SAVE U CORE DATA")
            saveStateImidiatelly()
        }
        
    }
    
}








protocol GameStateToWebReporting {
    func gameIsBecomingInactive(sid: Int?)
    func userEnterTheGame()
    
}

extension GameStateToWebReporting {
    func gameIsBecomingInactive(sid: Int?) {
//        print("SyncGameStateWithWebManaging/gameIsBecomingInactive is CALLED")
    }
    func userEnterTheGame() {
//        print("SyncGameStateWithWebManaging/userEnterTheGame is CALLED")
    }
}

protocol CrackTotemGameWebReporting: GameStateToWebReporting {
//    func getPayloadToReport(totem: CrackTotemSticker?) -> [String: Any]
    func updateGameStateToWebWas(successfull success: Bool?)
    func shouldReportGameStateToWeb() -> Bool
    func shouldSyncCrestReadingFromWeb(totem: CrackTotemSticker?) -> Bool
}

extension CrackTotemGameWebReporting {
    
    func updateGameStateToWebWas(successfull success: Bool?) {
        
        if let success = success, success {
            ud.set(true, forKey: GAME_CRACK_TOTEM_STATE_REPORTED_SUCCESSFULLY)
        } else { // false ili nil - nije javio bekendu..
            ud.set(false, forKey: GAME_CRACK_TOTEM_STATE_REPORTED_SUCCESSFULLY)
        }
        
    }
    
    func shouldReportGameStateToWeb() -> Bool { // procitaj flag ako ga ima, i prema tome sync
        
        guard let lastReportToWebWasSuccess = ud.value(forKey: GAME_CRACK_TOTEM_STATE_REPORTED_SUCCESSFULLY) as? Bool else {
            return false
        }
        
        return !lastReportToWebWasSuccess
        
    }
    
    func shouldSyncCrestReadingFromWeb(totem: CrackTotemSticker?) -> Bool {
        /*
        guard let webTotem = totem else { // uzmi parametrov ver
            return false
        }
        let ctx = appDel.persistentContainer.viewContext
        guard let myTotem = self.getStickerFor(sid: webTotem.sid, inCtx: ctx) else {return false}
        
//        print("shouldSyncCrestReadingFromWeb.treba da se sync = \(webTotem.ver >= myTotem.ver)")
        return webTotem.ver >= myTotem.ver // vrati proveru
        */
        print("shouldSyncCrestReadingFromWeb called, ne treba mi ova func...")
        return false
    }
    
}

extension CrackTotemGameWebReporting { // treba i AppDel-u (netwManager) i BrickWallVC
    
    func getStickerFor(sid: Int?, inCtx ctx: NSManagedObjectContext) -> CrackTotemSticker? {
        /*
        guard let sid = sid else { return nil }
        
        let fr: NSFetchRequest<CDCrackTotem> = CDCrackTotem.fetchRequest()
        var totems = [CDCrackTotem]()
        do {
            totems = try ctx.fetch(fr)
        } catch {
            return nil
        }
        
        guard let totem = totems.first,
            let s = totem.getCrackTotemSticker(sid: sid, ctx: ctx) else { return nil }
        
        return s // OK
        */
        
        print("CrackTotemGameWebReporting.getStickerFor(sid - ne treba da report to web, ali je dobro da posaljes obj iz bundle VC-u")
        
        return nil // ne treba da report to web, ali je dobro da posaljes obj iz bundle VC-u
    }
    
}


extension CrackTotemGameWebReporting { // ti citas core data....
    
    
    func getPayloadFor(sid: Int?) -> [String: Any]? {
        
        guard let sid = sid,
            let token = token,
            let totemData = getTotemAsJson(sid: sid),
            let controlStr = getControlStr(sid: sid)
            else { return nil }
        
        return ["token": token, "controlStr": controlStr, "stickerData": totemData ]
        
    }
    
    
    func getControlStr(sid: Int) -> String? {
        
        /*
        let ctx = appDel.persistentContainer.viewContext
        
        guard let s = getStickerFor(sid: sid, inCtx: ctx) else { return nil }
        
        let total_P = s.getTotal_P()
        let total_O = s.getTotal_O()
        
        let input = CT_GAME_SECURE_KEY + "\(total_O - total_P)"
        
        let digest = input.md5
        
        return digest
        */
        return nil // hard-coded, ne treba mi ova func....
        
    }
    
    
    func getTotemAsJson(sid: Int?) -> [String: Any]? { // implement me codable....
        /*
        //let ctx = appDel.persistentContainer.viewContext
        let ctx = appDel.persistentContainer.newBackgroundContext()
        guard let s = getStickerFor(sid: sid, inCtx: ctx) else { return nil }
        
        let count4Cripto = s.getTotal_O() - s.getTotal_P()
        let ver = s.ver
        
        var json = s.jsonRepresentation
        
        json?["ver"] = ver+1
//        print("totem: payload ver is = \(ver+1)")
        json?["count4Cripto"] = count4Cripto
        
        return json
        */
        return nil // hard-coded, ne treba mi da report to web....
        
        /*
        totem?.ver += 1 // bekendu javi da imas novu ver kod sebe
        guard let totalO = totem?.getTotal_O(),
            let totalP = totem?.getTotal_P() else {return nil}
        
        totem?.count4Cripto = totalO - totalP
        
        //        print("totem?.count4Cripto = \(String(describing: totem?.count4Cripto))")
        //        print("totem?.ver = \(String(describing: totem?.ver))")
        
        guard let json = totem?.jsonRepresentation else { return nil }
        
        return json
        */
    }
    
}







extension CrackTotemGameWebReporting where Self: BrickWallVC {
    
    func getControlStr(sid: Int) -> String? {
    
        /*
        let ctx = appDel.persistentContainer.viewContext
        
        guard let s = getStickerFor(sid: sid, inCtx: ctx) else { return nil }
        
        let total_P = s.getTotal_P()
        let total_O = s.getTotal_O()

        let input = CT_GAME_SECURE_KEY + "\(total_O - total_P)"

        let digest = input.md5

        return digest
        */
        
        return nil // hard-coded, ne treba mi uopste ova func...
        
    }
    
    func getTotemAsJson(sid: Int?) -> [String: Any]? { // implement me codable....
        
        //guard let sid = sid, let totemAsJson = totem?.sid else { return nil }
        
        totem?.ver += 1 // bekendu javi da imas novu ver kod sebe
        guard let totalO = totem?.getTotal_O(),
            let totalP = totem?.getTotal_P() else {return nil}
        
        totem?.count4Cripto = totalO - totalP
        
//        print("totem?.count4Cripto = \(String(describing: totem?.count4Cripto))")
//        print("totem?.ver = \(String(describing: totem?.ver))")
        
        guard let json = totem?.jsonRepresentation else { return nil }
        
        return json
 
    }
    
    // MARK: - fetch json data from bundle
    
    func readDecodedJsonDataFromBundle() -> CrackTotemSticker? {
        
        guard let readUrl = Bundle.main.url(forResource: "totemOriginal", withExtension: "json") else {
            return nil
        }
        
        let decoder = JSONDecoder.init()
        
        guard let jsonData = try? Data.init(contentsOf: readUrl) else {return nil}
        
        let stats = try? decoder.decode(CrackTotemSticker.self, from: jsonData)
        
        return stats
        
    }
    
    // MARK: - save actual totem to bundle
    
    func writeToJsonInBundle(totem: CrackTotemSticker?) {
        
        guard let totem = totem,
            let writeUrl = Bundle.main.url(forResource: "totemOriginal", withExtension: "json") else {
                return
        }
        
        let encoder = JSONEncoder.init()
        
        guard let jsonData = try? encoder.encode(totem) else {return}
        
        try? jsonData.write(to: writeUrl, options: .atomic)
        
    }
    
    private func getPayloadFor(sids: [Int]?) -> [[String: Any]]? { // kolekcija
        
        guard let sids = sids, !sids.isEmpty else { return nil}
        
        var totems = [[String: Any]]()
        
        for sid in sids {
         
            if let totem = getTotemAsJson(sid: sid) {
                totems.append(totem)
            }
            
        }
        
//        print("totems = \(totems)")
        return totems
        
    }
    
    private func reportToWeb(payload: [String: Any]) {
//        print("CrackTotemGameWebReporting.BrickWallVC/reportToWeb - implement me")
    }
    
    
    
    
    
    
    
    
    
    // "API"
    
//    func getPayloadToReport(totem: CrackTotemSticker?) -> [String: Any] {
//        print("CrackTotemGameWebReporting.BrickWallVC/getPayloadToReport - implement me")
//        return [:]
//    }
    
    func gameIsBecomingInactive(sid: Int?) {
        /*
        guard let payload = getPayloadFor(sid: sid) else { return }
        
//        print("saljem payload = \(payload))")
        
//        guard let payload = getPayloadFor(sid: totem.sid) else { return }
        
        CT_NetworkingAndCoreDataManager().updateCrestToWeb(payload: payload) { (success) in
            
//            print("gameIsBecomingInactive.success = \(String(describing: success))")
//            self.updateGameStateToWebWas(successfull: success) // update-uje flag
            updateCrackTotemGameStateToWebWas(successfull: success) // ova je global,nema ref na self
            
            // u oba slucaja: ver+1
            guard let success = success else { self.saveStateImidiatelly(); return } // no connection
            if !success {self.saveStateImidiatelly()} // ako bekend nije approve

            if success {
                self.updateCrackTotemsRegardingActualTotemState()
            }
            
        }
        */
        print("gameIsBecomingInactive sada je nepotrebna, inace je zvala web da report game_state")
        
    }
    
    private func updateCrackTotemsRegardingActualTotemState() {
        
        delegate?.updateStateFor(crackTotemSticker: totem)
        
    }
    
    
    
    // ovo je isto API jer ga moze pozivati AppDel -> netwManager da bi update sve records...
    
    
    
    func userEnterTheGame() {
//        print("SyncGameStateWithWebManaging/userEnterTheGame is CALLED")
        //procitaj totem sa web-a (bas za taj totem koji je izabrao!), sync se sa sobom ako je tamo ista ili novija ver, odnosno ako ima vise taps na serveru. u suprotnom, ne diraj nista nego eventualno povecaj ver
        /*
        guard let sid = totem?.sid else {return}
        
        CT_NetworkingAndCoreDataManager().getCrestFromWeb(sid: sid, successHandler: { (ctSticker) in
            
            DispatchQueue.main.async { // ako nemas istu ili noviju ver na web-u, onda izadji
                
                guard let totem = ctSticker else { return }
                
                guard self.shouldSyncCrestReadingFromWeb(totem: totem) else { return }
                
                // imas istu ili noviju ver sa web-a -> treba da se sync (write to core_data)
                
                 //let ctx = appDel.persistentContainer.newBackgroundContext()
//                let ctx = appDel.persistentContainer.viewContext
                
                self.totem = totem
                
                self.saveStateImidiatelly()
                
                //CDCrackTotem().updateStickerTotemToCoreData(totem: totem, ctx: ctx)
                
            }
            
        })
        */
        
        print("userEnterTheGame sada je nepotrebna, inace je zvala web da GET last saved game_state")
        
    }
    
}



func tryToSaveInContext(ctx: NSManagedObjectContext) {
    
    do {
        try ctx.save()
//        print("tryToSaveInContext/sacuvao sam na zadatom context-u . .. . ")
    } catch {
        print("tryToSaveInContext/catch.nisam uspeo da sacuvam...")
    }
    
}


func updateCrackTotemGameStateToWebWas(successfull success: Bool?) {
    
    if let success = success, success {
        ud.set(true, forKey: GAME_CRACK_TOTEM_STATE_REPORTED_SUCCESSFULLY)
    } else { // false ili nil - nije javio bekendu..
        ud.set(false, forKey: GAME_CRACK_TOTEM_STATE_REPORTED_SUCCESSFULLY)
    }
    
}
