//
//  BrickWallVC.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import QuartzCore

//class BrickWallVC: GameController {
class BrickWallVC: UIViewController {

    var _totem: CrackTotemSticker? {
        didSet {
            guard let totem = _totem else { return }
        }
    }
    
    var timer: Timer?
    let tm = BW_TimerManager()
    
    weak var delegate: TotemStateUpdating?
    
    @IBOutlet weak var bwBarView: BB_BricksBarView!
    
    @IBOutlet weak var totemImgView: UIImageView!
    
    @IBOutlet weak var bricksWallView: UIView!
    
    @IBOutlet weak var barInfoToSafeAreaCnstr: NSLayoutConstraint!
    
    @IBOutlet weak var hideBarInfoViewCnstr: NSLayoutConstraint!
    
    @IBOutlet weak var bwGameOverView: BW_GameOver!
    
    override func viewDidLoad() { super.viewDidLoad()
        
        super.viewDidLoad()
        
        loadTotemFromBundle()
        
        gameHasBegun()
        
        attachDelegates()
        
        tm.recreateState(timer: &timer) // ovo ce da napuni VALUE odakle citas
        
        userEnterTheGame()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.userQuitGame() // ima iz ex. BrickWallVC: CrackTotemSaveStateManaging {} // protocols_2
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        tm.saveState()
        
        timer?.invalidate(); timer = nil
        
        //game = nil ,off now
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        redrawBrickWall(totem: _totem) // by protocol
        
        loadTotemImgView(totem: _totem)
        
        loadBricksBarView(totem: _totem)
        
        bricksWallView.backgroundColor = .clear // na SB sam set na neku drugu jer se video transitioning
        
        hookUpDelegateToBarComponents()
        
        tm.viewDidAppear()
        
    }
    
    func getCellFromActualTotem(forCellId cellId: Int?) -> Cell? {
        guard let cellId = cellId, let totem = totem else { return nil }
        let rows = totem.rows
        let cellsByCellId = rows.map {$0.cells}.joined()
        let cells = cellsByCellId.filter {$0.cId == cellId}
        
        guard !cells.isEmpty, let cell = cells.first else {
//            print("getCellFromActualTotem.ERROR, nisam nasao cell za dati CellId")
            return nil
        }
        
        return cell
    }
    
    func hammerBecameAvailable() { // javice ti neko (counter manager)
        
        self.playSound(.bwHammerBecameAvailable)
        
    }
    
    // MARK:- Privates
    
    private func gameHasBegun() {
        
        //,off now
//        guard let meEmail = intermediateForUser.actualUser?.email else { return }
//        game?.addOponentWith(meEmail)
    
    }
    
    private func attachDelegates() {
        
        tm.delegate = self
        
        bwGameOverView.delegate = self
        
        bwBarView.delegate = self // javice mi kada je score == 0
        
    }
    
    private func hookUpDelegateToBarComponents() { // process od didLoad
        
        for sv in bwBarView.subviews.first!.subviews.first!.subviews {
            if let hv = sv as? BB_HammerView {
                hv.delegate = self
            }
            if let btv = sv as? BB_BuyTotemView {
                btv.delegate = self
            }
        }
        
    }
    
    private func loadTotemImgView(totem: CrackTotemSticker?) {
        
        /*
        guard let totem = totem else { return }
        
        //let totalSid = totem.sid // u ORIGINAL app imam method koji dovlaci sliku iz CD
        
        //totemImgView.image = UIImage.init(named: "ronaldo") // HC
        
        totemImgView.image = coreDataStickerManager.getStickerPhotoForSID(totem.sid).image
        */
        
        print("loadTotemImgView: treba da load image (iz svojih assets) za totem tj totem.sid")
    }
    
    private func loadBricksBarView(totem: CrackTotemSticker?) {
        
        func dropShadows() {
            
            self.dropDiagShadow(inView: bwBarView.buyTotemView.shadeView, insetValuePercent: 10, shadowColor: CT_GRAY_43)
            
            self.dropDiagShadow(inView: bwBarView.hammerView.shadeView, insetValuePercent: 10, shadowColor: CT_GRAY_43)
        }
        
        guard let totem = totem else { return }
        
        guard totem.getScore() > 0 else { // ako je zavrsio ovaj totem ( == 0 )
            //gameIsFinished() // prikazi mu view, da je vec zaradio ovaj sticker
            translateBarInfoViewBelowNavBar() // prikazi mu view, da ima ovaj sticker
            return // izadji...
        }
        
        let hammerActive = isHammerActive()
        
        let counterText = getCounterText()
        
        bwBarView?.updateBricksBarView(totem: totem, coinType: .gold, hammerActive: hammerActive, counterTime: counterText)
        
         dropShadows() // postavi shadows na buyTotemView i hammerView - - HC TEMP OFF
        
    }
    
    @objc func updateClock() {
        
        guard let val = tm.getCounterValue() else {
            //print("error reading from TimeManager");
            return }
            
//        print("updateClock.val = \(val)")
        
        updateUI(countVal: val, hammerIsActive: isHammerActive(), hammerIsAvailable: isHammerAvailable() ?? false) // HC !
    
    }
    
    private func updateUI(countVal: String, hammerIsActive: Bool, hammerIsAvailable: Bool) {
        
        let hammerOn = (hammerIsActive || hammerIsAvailable)
        
        let hammerImg = hammerOn ? #imageLiteral(resourceName: "hammer_ON") : #imageLiteral(resourceName: "hammer_OFF")
        
        let clockImg: UIImage? = (countVal == CT_USE_HAMMER) ? nil : (hammerIsActive) ? #imageLiteral(resourceName: "stopwatch_ON") : #imageLiteral(resourceName: "stopwatch")
        
        let lblTxtColor: UIColor = hammerOn ? .white : .black
        
        let frameColor: UIColor = hammerOn ? CT_LIGHT_BLUE_COLOR : CT_GRAY_73
        
        bwBarView.hammerView.updateView(imgFirst: hammerImg, imgSecond: clockImg, text: countVal, lblTxtColor: lblTxtColor, borderColor: frameColor)
        
    }
    
    // MARK:- respond to gameOver msg
    
    fileprivate func showGameOverInfoView() {

        bwGameOverView.isHidden = false
        
        self.playSound(SoundMessage.bwGameFinished)
        
    }
    
    fileprivate func translateBarInfoViewBelowNavBar() {
        
        bwBarView?.stackTopToSafeAreaTopCnstr?.isActive = false // iz nekog razloga moram da ugasim nesto od height constraint-a na njegovom stack-u ?!?
        barInfoToSafeAreaCnstr?.isActive = false
        hideBarInfoViewCnstr?.isActive = true
        
    }
    
    // MARK:- Privates - fetch data
    
    private func loadTotemFromBundle() { // treba Filesystem !
        
        // _totem = ovde napuni ovu var, a mozes i da nakon toga odavde pozoves redrawTotem
        
        guard let readUrl = FileManager.documentDirectoryUrl?.appendingPathComponent("totemOriginal").appendingPathExtension("json") else { return }
        
        let decoder = JSONDecoder.init()
        
        guard let jsonData = try? Data.init(contentsOf: readUrl) else {return}
        
        let savedTotem = try? decoder.decode(CrackTotemSticker.self, from: jsonData)
        
        _totem = savedTotem
        
    }
    
    // MARK:- Privates - write data
    
    func saveTotemToBundle() { // treba ToFile
        
        // _totem = ovde napuni ovu var, a mozes i da nakon toga odavde pozoves redrawTotem
        
        guard let totem = totem,
            let writeUrl = FileManager.documentDirectoryUrl?.appendingPathComponent("totemOriginal").appendingPathExtension("json") else { return}
        
        let encoder = JSONEncoder.init()
        
        guard let jsonData = try? encoder.encode(totem) else {return}
        
        try? jsonData.write(to: writeUrl, options: .atomic)
        
    }
    
}

extension BrickWallVC: SingleBrickPresenting {} // mora da zna da prikaze ciglu

extension BrickWallVC: BrickTapResponsing {} // i da reaguje na Tap koji mu cigla javi

extension BrickWallVC: TriangleShapedShadowDroping {} // protocols_2

extension BrickWallVC: BuyTotemAndHammerBtnTapManaging {
    
    func btnTapped(sender: UIButton) {
        guard let t = _totem else { return }
        
        if sender.tag == 0 { // handle buy sticker asset for gold coin
        
            let goldCost = AG_ASSET_GOLD_COST // za sada hoce da bude fiksno 10
            guard let userId = email else { return }
            
            buyStickerForGoldCoins(token: token, userId: userId, sid: t.sid, gold: goldCost) {success in
                if success {
                    self.userBoughtStickerFromAlbumGame()
                } else {
//                    print("BrickWallVC.BuyTotemAndHammerBtnTapManaging.btnTapped(success == false")
                }
            }
            
        } else if sender.tag == 1 {
            
            userTappedHammerBtn()
            
        }
        
    }
    
} // protocols_2

extension BrickWallVC: BrickBarManaging {} // protocols_2


extension BrickBarManaging where Self: BrickWallVC {
    
    // sakrij barInfoView ispod navBar-a
    // prikazi gameOverInfoView
    func gameIsFinished() {
        
        showGameOverInfoView()
        
        translateBarInfoViewBelowNavBar()
        
        placeInstantlyIntoAlbum(sid: totem?.sid) //zalepi sam kod sebe, server kasni...
        
    }
    
    private func placeInstantlyIntoAlbum(sid: Int?) {
        /* now off
        guard let sid = sid,
            let sticker = CDSticker.getStickerForCDStickerWith(sid: sid) else {return}
        
        intermediateForUser.actualUser?.stickers.append(sticker)
        */
        
        // (to-do) u svom modelu zapisi da ima ovaj sticker (placed == true)
    }
}

extension BrickWallVC: CrackTotemSaveStateManaging {} // protocols_2

extension BrickWallVC: CrackTotemGameWebReporting {} // protocols_2

extension BrickWallVC: PlayingSound {} //

extension BrickWallVC: AlbumGameAssetBuying { // dobio od protocol-a 'func buyStickerForGoldCoins'
    
    func userBoughtStickerFromAlbumGame() {

        /*
        func checkIfUIisAvailableAndCleanVC(me: BrickWallVC) {
            me.bricksWallView?.removeAllMySubviews()
            me.gameIsFinished()
        }
        
        DispatchQueue.main.async { [weak self] in
            
            guard let strongSelf = self else { return }

//            strongSelf.bricksWallView?.removeAllMySubviews()
//            strongSelf.gameIsFinished()
            
            checkIfUIisAvailableAndCleanVC(me: strongSelf)
            
            // implement me, treba da zoves GET svih crackTotems da bi sync model
            
            guard let sid = strongSelf._totem?.sid else { return }

            let manager = CT_NetworkingAndCoreDataManager()

            manager.getCrestFromWeb(sid: sid, successHandler: { (ctSticker) in

                DispatchQueue.main.async { // moras na main zbog 'appDel'

                    guard let totem = ctSticker else { return }
                    
                    let ctx = appDel.persistentContainer.viewContext

                    CDCrackTotem().updateStickerTotemToCoreData(totem: totem, ctx: ctx)

                    tryToSaveInContext(ctx: ctx)
                    
                    checkIfUIisAvailableAndCleanVC(me: strongSelf)

                }

            })
            
        }
        */
        
        print("userBoughtStickerFromAlbumGame.implement me, ugasio sam code koji je bio ranije///")
        
    }
    
}
