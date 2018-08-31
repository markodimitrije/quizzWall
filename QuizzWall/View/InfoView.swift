//
//  InfoView.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 31/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

@IBDesignable
class InfoView: UIView {
    
    @IBInspectable
    @IBOutlet weak var gemsView: BtnWithInlineImgImgLbl!
    @IBInspectable
    @IBOutlet weak var hammerView: BtnWithInlineImgImgLbl!
    @IBInspectable
    @IBOutlet weak var timeLeftLbl: UILabel!
    @IBOutlet weak var counterLbl: UILabel!
    
//    @IBAction func btnIsTapped(_ sender: UIButton) {
//
//        //        print("BtnBesideBtnView.btnIsTapped, sender.tag = \(sender.tag)")
//
//        btmDelegate?.btnTapped(sender: sender)
//    }
    
    weak var btmDelegate: BtnTapManaging?
    
    // + imas default implementaciju func-ja
    
    var leftBtnTag: Int = 0
    var rightBtnTag: Int = 0
    
    var timeLeft: String? {
        get {
            return timeLeftLbl?.text
        }
        set {
            timeLeftLbl?.text = newValue
        }
    }
    
    var count: String? {
        get {
            return counterLbl?.text
        }
        set {
            counterLbl?.text = newValue
        }
    }
    
    // end adopt protocols
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    // new code:
    convenience init(position: CGPoint) {
        var frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 50)
        frame.origin = position
        self.init(frame: frame)
        loadViewFromNib()
    }
    
    convenience init(position: CGPoint, frame: CGRect) {
        var frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        frame.origin = position
        self.init(frame: frame)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        //        print("BtnBesideBtnView.loadViewFromNib at is CALLED")
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "InfoView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
    
    // MARK: -API
    
    func set(gemsCount: Int, hammerCount: Int, timeLeftText: String?, counter: String?) {
        self.gemsView?.set(leftImg: nil, rightImg: #imageLiteral(resourceName: "gem_1"), text: "\(gemsCount)")
        self.hammerView?.set(leftImg: nil, rightImg: #imageLiteral(resourceName: "hammer_ON"), text: "\(hammerCount)")
        self.timeLeft = timeLeftText
        self.count = counter
    }
    
}
