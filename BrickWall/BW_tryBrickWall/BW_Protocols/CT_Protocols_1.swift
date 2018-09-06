//
//  CT_Protocols_1.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import CoreData

protocol BrickWallManaging {
    var totem: CrackTotemSticker? { get set }
    func userChoseTotemSid(_ sid: Int?)
    func redrawBrickWall(totem: CrackTotemSticker?)
    
}

extension BrickWallManaging {
    
    func userChoseTotemSid(_ sid: Int?) {
//        print("BrickWallManaging.reportTotemSid: implement me")
    }
    
    func recreateBrickWall(totem: CrackTotemSticker?) {
//        print("BrickWallManaging.recreateBrickWall: implement me")
    }
}

extension BrickWallVC: BrickWallManaging {
    
    var totem: CrackTotemSticker? {
        get {
            return _totem
        }
        set {
            _totem = newValue
        }
    }
    
    private func loadTotemFromJsonInBundle() {
        
        guard let filePath = Bundle.main.path(forResource: "totemTemp", ofType: "json"),
            let data = NSData(contentsOfFile: filePath) else {
//                print("error. nemam resource")
                return
        }
        
        do { // here you have your json parsed as string:
            
            totem = try JSONDecoder().decode(CrackTotemSticker.self, from: data as Data)
            
        }
        catch { print("readBtnIsTapped.ERROR: cant parse jsonData") }
        
    }
    
    
    
    private func loadTotemFromCoreData(sid: Int?) {
        
        /*
        let req: NSFetchRequest<CDCrackTotem> = CDCrackTotem.fetchRequest()
        
        var cdTotem: CDCrackTotem?
        
        do {
            cdTotem = try context.fetch(req).first
        } catch {
            print("loadTotemFromCoreData.catch: ne mogu da fetch from core data model")
        }
        
        guard let cts = cdTotem?.getCrackTotemSticker(sid: sid, ctx: context) else {
            print("loadTotemFromCoreData.Else: loadTotemFromCoreData.err: nemam fetch iz CD modela")
            return
        }
        
        totem = cts
        */
        
        print("loadTotemFromCoreData turned off, use call |   loadTotemFromJsonInBundle   |")
        
    }
    
    
    
    
    private func getJsonPayloadForSyncWithWeb() -> [String: Any] { // depricated ?
        
//        print("getJsonPayloadForSyncWithWeb is cALLED, implement me")
        return [:]
        
    }
    
    
    
    
    // MARK:-
    
    func userChoseTotemSid(_ sid: Int?) {
        
        guard let sid = sid else { return }
        
        loadTotemFromCoreData(sid: sid) // ali treba mi ovakav model
        
    }
    
    func redrawBrickWall(totem: CrackTotemSticker?) { // probaj sa Internal
        
        guard let totem = totem else {
            
            return

        }
        
        for row in totem.rows {
            
            //recreateBrickRow(row: row, totem: totem)
            recreateBrickRowWithAnimation(row: row, totem: totem)
            
        }
        
    }

    // ova radi, bez animacije:
    /*
    func recreateBrickRow(row: Row, totem: CrackTotemSticker) { // probaj sa Internal

        for cell in row.cells {

            let bi = SingleBrickInfo.init(numOfRows: totem.numOfRows, row: row, cell: cell)

            guard let v = self.createSingleBrick(brickInfo: bi, totalWallWidth: self.bricksWallView.bounds.width) else {
                return
            }

            self.bricksWallView?.addSubview(v)

        }

    }
    */
    
    // hocu da imam animaciju
    
    func recreateBrickRowWithAnimation(row: Row, totem: CrackTotemSticker) { // probaj sa Internal
        
        let rowIndex = row.rowId
        
        for (cellIndex, cell) in row.cells.enumerated() {
            
            let bi = SingleBrickInfo.init(numOfRows: totem.numOfRows, row: row, cell: cell)
            
            guard let v = self.createSingleBrick(brickInfo: bi, totalWallWidth: self.bricksWallView.bounds.width) else {
                return
            }
            
            v.alpha = 0 // inicijalno se ne vide
            
            // ovako se redjaju na svakih 0.33 sec
            //let delay: TimeInterval = TimeInterval(rowIndex) + TimeInterval(cellIndex) * 0.33
            
            // ovako je 10xbrze (odlicno) + cigle se slazu odozdo na gore (totem.numOfRows - rowIndex)
            let delay: TimeInterval = 0.1*TimeInterval(totem.numOfRows - rowIndex) + TimeInterval(cellIndex) * 0.033 //  0.1 by 0.033 -> 10 rows se poredja za 1 sec
            
            self.bricksWallView?.addSubview(v)
            
            UIView.animate(withDuration: 0.1, delay: delay,
                           options: .curveLinear,
                           animations: {
                                v.alpha = 1
                            }, completion: nil)
        }
        
    }
    
}






protocol SingleBrickPresenting {
    func createSingleBrick(brickInfo: Any?, totalWallWidth: CGFloat) -> BW_BrickView?
    func updateSingleBrick(brickInfo: Any?)
    func getImageFor(brickPattern: BW_BrickPattern, index: Int?) -> UIImage?
    func getCrackIndex(o: Int, p: Int) -> Int?
}

extension SingleBrickPresenting {
    
    func createSingleBrick(brickInfo: Any?, totalWallWidth: CGFloat) -> BW_BrickView? {
//        print("SingleBrickPresenting.createSingleBrick: implement me")
        return nil
    }
    
    func updateSingleBrick(brickInfo: Any?) {
//        print("SingleBrickPresenting.updateSingleBrick: implement me")
    }
    
    func getImageFor(brickPattern: BW_BrickPattern, index: Int?) -> UIImage? {
//        print("SingleBrickPresenting.getImageFor: implement me")
        return nil
    }
    
    func getCrackIndex(o: Int, p: Int) -> Int? {
//        print("SingleBrickPresenting.getCrackIndex: implement me")
        return nil
    }
}

extension SingleBrickPresenting where Self: BrickWallVC {
    
    // MARK: - Privates
    
    private func getStartingAxisPos(row: Row, cellId: Int, bwTotalW: CGFloat) -> CGFloat {
        
        //let cellIds = row.cells.map {$0.cId}
        let beforeCells = row.cells.filter {$0.cId < cellId}
        let cellWidhts = beforeCells.map {CGFloat.init($0.w)/CGFloat.init(100)*SCREEN_WIDTH} // HC
        let totalWidth = cellWidhts.reduce(0){ $0 + $1 }
        return totalWidth
        
    }
    
    // MARK: - API
    
    func getCrackIndex(o: Int, p: Int) -> Int? {
        guard o < p else { return nil }
        // broj assets lx.png -> imam ih 8
        
        let level = Float.init(p) / Float.init(8) // recimo da ima 10 nivoa, mada ih i assets imam 7; +1 od 0 - no img
        let actual = Float.init(o) / level
        return Int.init(actual)
    }
    
    
    func getImageFor(brickPattern: BW_BrickPattern, index: Int?) -> UIImage? {
        
        guard let index = index, index >= 0 else { return nil }
        
        // .t: "c", .b: "b", .i: "l" - - - > 'c': Cigla, 'b': Bordura, 'l': Lomljeno
        let patternNames: [BW_BrickPattern: String] = [.t: "c", .b: "b", .i: "l"]
        
        let knownPatterns = patternNames.keys
        
        guard knownPatterns.contains(brickPattern) else { return nil }
        
        guard let imgBordureName = patternNames[brickPattern] else { return nil }
        
        return UIImage.init(named: imgBordureName + "\(index)")
        
    }
    
    
    func createSingleBrick(brickInfo: Any?, totalWallWidth: CGFloat) -> BW_BrickView? { // treba param inHostView: UIView
        
        guard let info = brickInfo as? SingleBrickInfo else { return nil }
        
        // calculate dimensions: size
        let rowHeight = self.bricksWallView.bounds.height / CGFloat.init(info.numOfRows)
        let cellWidthProcent = CGFloat.init(info.cell.w)
        let cellWidth = cellWidthProcent/100 * totalWallWidth
        
        // calculate dimensions: origin
        let yPos = CGFloat.init(info.row.rowId) * rowHeight
        let xPos = getStartingAxisPos(row: info.row, cellId: info.cell.cId, bwTotalW: self.bricksWallView.bounds.width)
        
        // calculate dimensions: frame
        let or = CGPoint.init(x: xPos, y: yPos)
        let size = CGSize.init(width: cellWidth, height: rowHeight)
        
        let frame = CGRect.init(origin: or, size: size)
        
        // create brick properties
        //let cellTxt = info.cell.txt // ovo je dodeli npr name Boby Charlton koje si dobio u data
        //let cellTxt = "\(info.cell.o)" + " / " + "\(info.cell.p)" // ovo je calculate: otk/uk za tu cell
        let cellTxt = "\(info.cell.p - info.cell.o)"
        let tImg = getImageFor(brickPattern: .t, index: info.cell.t)
        let bImg = getImageFor(brickPattern: .b, index: info.cell.b)
        
        let iImg = getImageFor(brickPattern: .i,
                               index: getCrackIndex(o: info.cell.o, p: info.cell.p))
        
        let brickView = BW_BrickView.init(cellId: info.cell.cId, frame: frame, bImg: bImg, tImg: tImg, iImg: iImg, txt: cellTxt)
        
        brickView.delegate = self
        
        brickView.isHidden = (info.cell.o == info.cell.p) // otkucane do kraja, ne prikazuj
        
        return brickView
     
    }
    
    func updateSingleBrick(brickInfo: Any?) {
        
        guard let info = brickInfo as? SingleBrickInfo else { return }
        
        // implement me
        
    }
    
    
}


//getTapValue(hammerActive: hammerActive)

protocol BrickTapResponsing: class {
    func brickTappedAt(cellId: Int?)
    func isHammerActive() -> Bool
    func getTapValue(hammerActive: Bool) -> Int
}

extension BrickTapResponsing {
    func brickTappedAt(cellId: Int?) {
//        print("BrickTapReporting.brickTappedAt: implement me")
    }
    func getTapValue(hammerActive: Bool) -> Int {
//        print("BrickTapReporting.getTapValue: implement me")
        return 1
    }
    func isHammerActive() -> Bool {
//        print("BrickTapReporting.isHammerActive: implement me")
        return false
    }
}

extension BrickTapResponsing where Self: BrickWallVC {
    
    private func updateLocalModel(cellId: Int, value: Int) -> Cell? { // updateActualTotemData

        let cell = totem?.updateCell(withCellId: cellId, newTaps: value) // update LOCAL VAR (mem, heap)
        
        return cell
        
    }
    
    func getCounterText() -> String {
        
        let txt = tm.getCounterValue() ?? ""
        return txt
    }
    
    func isHammerActive() -> Bool {
        
        return tm.isUserUsingHammer() // OK
        
    }
    
    func getTapValue(hammerActive: Bool) -> Int {

        return ( hammerActive ) ? CT_BRICK_TAP_VAL_GAIN : CT_BRICK_TAP_VAL_REG

    }
    
    func getTapValue() -> Int { return CT_BRICK_TAP_VAL_FOR_QUIZZ } // 100 points
    
    func brickTappedAt(cellId: Int?) {
        
        guard let shouldUpdateBrick = BW_Model.userHasEnoughHammerPoints() else { return }
        if shouldUpdateBrick {
            brickTappedAndUserHasHammerPoints(cellId: cellId)
        } else {
            self.performSegue(withIdentifier: "segueShowQuizzVC", sender: nil)
        }
        
    }
    
    private func brickTappedAndUserHasHammerPoints(cellId: Int?) {
        
        modelStateIsChanged()
        
        guard let cellId = cellId else { return }
        
        let value = getTapValue()
        
        guard let cell = updateLocalModel(cellId: cellId, value: value) else { return }
        
        let selectedView = self.bricksWallView.subviews.first(where: { (sv) -> Bool in
            guard let sv = sv as? BW_BrickView else { return false }
            return sv.cellId == cellId
        })
        
        guard let brickView = selectedView as? BW_BrickView else { return }
        
        //        print("cell.o = \(cell.o)")
        //        print("cell.p = \(cell.p)")
        
        brickView.isHidden = (cell.o >= cell.p) // logicno je == ali moze da koristi i hammer (.o by 5)
        
        let crackIndex = getCrackIndex(o: cell.o, p: cell.p)
        
        let updatedImg = getImageFor(brickPattern: .i, index: crackIndex)
        
        let crackImgWillBeUpdated = brickView.iImgView.image != updatedImg // actual vs. new
        
        brickView.updateBrick(otk: cell.o, total: cell.p, img: updatedImg)
        
        bwBarView.updateBricksBarView(totem: totem)
        
        //makeIphoneVibrate() probati za > iphone 7
        
        modelStateIsChanged()
        
        checkForSoundOnBrickTapped(cell: cell,
                                   crackImgUpdated: crackImgWillBeUpdated)
        
    }
    
    // proveravas od 'najveceg' ka 'najmanjem' dogadjaju
    
    private func checkForSoundOnBrickTapped(cell: Cell?, crackImgUpdated: Bool = false) {
        
        // zavrsio je Totem:
        if self.totem?.getTotal_O() == self.totem?.getTotal_P() {
            self.playSound(.bwGameFinished); return
        }
        
        guard let cell = cell else { return }
        
        // zavrsio je jednu ciglu:
        if cell.o >= cell.p {
            self.playSound(.bwBrickFinished); return
        }
        
        // napravio je veci krhotinu na cigli:
        if crackImgUpdated {
            self.playSound(.bwBrickCracked); return
        }
        
        // jedan Tap:
        //let playSound: SoundMessage = isHammerActive() ? .bwTapStrong: .bwTapRegular
        
        //self.playSound(playSound)
        
    }
    
}
