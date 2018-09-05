//
//  BtnWithInlineImgImgLbl.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 30/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

@IBDesignable
class BtnWithInlineImgImgLbl: UIView {
    
    @IBInspectable
    @IBOutlet weak var leftImgView: UIImageView!
    @IBInspectable
    @IBOutlet weak var rightImgView: UIImageView!
    @IBInspectable
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func btnIsTapped(_ sender: UIButton) {
        
        //        print("BtnBesideBtnView.btnIsTapped, sender.tag = \(sender.tag)")
        
        btmDelegate?.btnTapped(sender: sender)
    }
    
    weak var btmDelegate: BtnTapManaging?
    
    // + imas default implementaciju func-ja
    
    var leftImg: UIImage? {
        get {
            return leftImgView?.image
        }
        set {
            leftImgView?.image = newValue
        }
    }
    
    var rightImg: UIImage? {
        get {
            return rightImgView?.image
        }
        set {
            rightImgView?.image = newValue
        }
    }
    
    var text: String? {
        get {
            return label?.text
        }
        set {
            label?.text = newValue
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
    
    convenience init(position: CGPoint, frame: CGRect, leftImage: UIImage?, rightImage: UIImage?) {
        
        self.init(position:position, frame: frame)
        
        self.leftImg = leftImage
        self.rightImg = rightImage
    }
    
    func loadViewFromNib() {
        //        print("BtnBesideBtnView.loadViewFromNib at is CALLED")
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BtnWithInlineImgImgLbl", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
    
    // MARK: -API
    
    func set(leftImg: UIImage?, rightImg: UIImage?, text: String?) {
        self.leftImg = leftImg
        self.rightImg = rightImg
        self.text = text
    }
    
}









