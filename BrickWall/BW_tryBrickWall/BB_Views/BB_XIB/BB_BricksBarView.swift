//
//  BW_BrickView.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

//@IBDesignable
class BB_BricksBarView: UIView {
    
    var view: UIView!
    
    weak var delegate: BrickBarManaging?
    
    // Outlets and Actions: - start
    
    @IBOutlet weak var tnameScoreView: BB_TNameScoreView!
    
    @IBOutlet weak var buyTotemView: BB_BuyTotemView!
    
    @IBOutlet weak var hammerView: BB_HammerView!
    
    @IBOutlet weak var stackTopToSafeAreaTopCnstr: NSLayoutConstraint!
    
    
    // Outlets and Actions: - end
    
    // storage vars - start:
    
    var tapsWorthForCoinType: [CoinType: Int] = [.gold: CT_GOLD_WORTH_TAPS,
                                                 .silver: CT_SILVER_WORTH_TAPS]
    
    var imgForCoinType: [CoinType: UIImage] = [.gold: #imageLiteral(resourceName: "gold_icon_coin"),
                                               .silver: #imageLiteral(resourceName: "silver_icon_coin")]
    
    // storage vars - end:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib ()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib ()
    }
    
    // new code:
    convenience init(position: CGPoint) {
        var frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        frame.origin = position
        self.init(frame: frame)
        loadViewFromNib ()
    }
    
    // ne koristim je, grade se sa storyboard-a -> pitanje je da li ispravno rade...
    convenience init(frame: CGRect, totem: CrackTotemSticker, hammerActive: Bool, counterTime: String) {
        self.init(frame: frame)
        
        let tnsv = getInfoView(totem: totem)
        
        let coinType = delegate?.getCoinTypeForBuyingTotem() ?? .gold // by Protocols_2
        
        let bcv = getBuyCreditsView(totem: totem, coinType: coinType)

        let hmv = getHammerView(totem: totem, hammerActive: hammerActive, counter: counterTime)
        
        let outletCollection = Set.init(arrayLiteral: tnameScoreView, buyTotemView, hammerView)
        
        for ov in outletCollection {
            for sv in ov.subviews {
                sv.removeFromSuperview()
            }
        }
        
        tnameScoreView.addSubview(tnsv)
        buyTotemView.addSubview(bcv)
        hammerView.addSubview(hmv)
        
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BB_BricksBarView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
    }
    
    // MARK:- API
    
    func updateBricksBarView(points: String) {
        hammerView.updateView(text: points)
    }

    func updateBricksBarView(totem: CrackTotemSticker, coinType: CoinType?, hammerActive: Bool, hammerPoints: String) {
    
        let coinType = delegate?.getCoinTypeForBuyingTotem()
        
        // update 1. view
        let (tname, tscore) = getTotemNameAndScoreComponents(totem: totem)
        tnameScoreView.updateView(upperLblText: tname, lowerLblText: tscore)
        
        // update 2. view
        let (coinImg, buyTotemMsg) = getBuyTotemComponents(totem: totem, coinType: coinType)
        
        buyTotemView.updateView(image: coinImg, msgText: buyTotemMsg)
        
        // update 3. view
        
        
        let hvComponents: (UIImage?, UIImage?, String?) = getHammerViewComponents(totem: totem, hammerActive: hammerActive, hammerPoints: hammerPoints)
        
        hammerView.updateView(imgFirst: hvComponents.0, imgSecond: hvComponents.1, text: hvComponents.2)
    }
    
    func updateBricksBarView(totem: CrackTotemSticker?) {
        
        guard let totem = totem else { return }
        
        // update 1. view
        let (tname, tscore) = getTotemNameAndScoreComponents(totem: totem)
        tnameScoreView.updateView(upperLblText: tname, lowerLblText: tscore)
        
        // update 2. view
        let (coinImg, buyTotemMsg) = getBuyTotemComponents(totem: totem, coinType: .gold)
        buyTotemView.updateView(image: coinImg, msgText: buyTotemMsg)
        
        checkIfCrackingTotemIsFinished(tscore: tscore)
    }
    
    // MARK:- Privates
    
    private func getInfoView(totem: CrackTotemSticker) -> UIView {
        
        let name = totem.name
        let score = "22450" // HC, needs to calculate ...
        let f = CGRect.init(x: 0, y: 0, width: 120, height: 70)
        let v = BB_TNameScoreView.init(frame: f, upperLblText: name, lowerLblText: score)
        
        return v
        
    }
    
    
    private func getBuyCreditsView(totem: CrackTotemSticker, coinType: CoinType) -> UIView {
        
        let f = CGRect.init(x: 120, y: 0, width: 160, height: 70)
        
        let tapsRequired = Int.init(exactly: abs(totem.count4Cripto)) ?? 0
        
        let tapsActual = totem.getTotal_O()
        
        //let value = (tapsRequired - tapsActual) / tapsWorthForCoinType[coinType]!
        let value = 10 // za sada hocemo fiksno 10 gold coins
        
        let msg = CT_BUY_FOR + " \(value)"
        
        let v = BB_BuyTotemView.init(frame: f, image: imgForCoinType[coinType], msgText: msg)
        
        return v
        
    }
    
    private func getHammerView(totem: CrackTotemSticker, hammerActive: Bool, counter: String?) -> UIView {
        
        let f = CGRect.init(x: 250, y: 0, width: 150, height: 70)
        
        let imgFirst: UIImage? = hammerActive ? #imageLiteral(resourceName: "hammer_ON") : #imageLiteral(resourceName: "hammer_OFF")
        
        let imgSecond: UIImage? = nil // modified (na quizzWall ne zelim timer...)
        
        let v = BB_HammerView.init(frame: f, imgFirst: imgFirst, imgSecond: imgSecond, text: counter)
        
        return v
        
    }
    
    private func getTotemNameAndScoreComponents(totem: CrackTotemSticker) -> (String?, String?) {
        
        let res = totem.getTotal_P() - totem.getTotal_O()
        
//        print("getTotemNameAndScoreComponents/ vracam SCORE: \(totem.getTotal_P()) - \(totem.getTotal_O()) = \(res)")
        
        return (totem.name, "\(res)")
        
    }
    
    private func getBuyTotemComponents(totem: CrackTotemSticker, coinType: CoinType?) -> (UIImage?, msg: String?) {
        
        //let tapsRequired = Int.init(exactly: abs(totem.count4Cripto)) ?? 0
        let tapsRequired = totem.getTotal_P()
        
        let tapsActual = totem.getTotal_O()
        
        let coinType = coinType ?? .gold
        
        let value = (tapsRequired - tapsActual) / tapsWorthForCoinType[coinType]!
        
//        let msg = CT_BUY_FOR + " \(value + 1)" // +1 jer uvek ima mogucnost da kupi, i na 3 tap-a
        let msg = CT_BUY_FOR + " \(10)" // hocemo uvek fiksno 10 coins
        
        return (imgForCoinType[coinType], msg)
        
    }
    
    
    // counter treba da je u seconds, pa da ga ti format u zeljeni string....
    private func getHammerViewComponents(totem: CrackTotemSticker, hammerActive: Bool, hammerPoints: String?) -> (UIImage?, UIImage?, String?) {
        
        let imgFirst: UIImage? = hammerActive ? #imageLiteral(resourceName: "hammer_ON") : #imageLiteral(resourceName: "hammer_OFF")
        
        let imgSecond: UIImage? = hammerActive ? nil : #imageLiteral(resourceName: "stopwatch")
        
        return (imgFirst, imgSecond, hammerPoints)
        
    }
    
    private func checkIfCrackingTotemIsFinished(tscore: String?) {
        
        guard let tscore = tscore else { return }
        
        if tscore == "0" { // igra je zavrsena, skloni view sa buyTotem i countTime for Hammer...
            
            delegate?.gameIsFinished()
            
        }
        
    }
    
    private func showGameOverInfo() {
        
        
        
    }
    
    
}
