//
//  BW_GameOver.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 16/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class BW_GameOver: UIView {
    
    var view: UIView!
    
    weak var delegate: BtnTapManaging?
    
    @IBAction func btnTapped(_ sender: UIButton!) {
        delegate?.btnTapped(sender: sender) // ima tag 20!
    }
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var upperLbl: UILabel! {
        didSet {
            upperTxt = CT_GAME_OVER_TITLE
        }
    }
    @IBOutlet weak var lowerLbl: UILabel! {
        didSet {
            lowerTxt = CT_GAME_OVER_MSG
        }
    }
    
    private var img: UIImage? {
        get {
            return imgView?.image
        }
        set {
            imgView?.image = newValue
        }
    }
    
    var upperTxt: String? {
        get {
            return upperLbl?.text
        }
        set {
            upperLbl?.text = newValue
        }
    }
    
    var lowerTxt: String? {
        get {
            return lowerLbl?.text
        }
        set {
            lowerLbl?.text = newValue
        }
    }
    
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
    
    convenience init(frame: CGRect, img: UIImage?, upperTxt: String?, lowerTxt: String?) {
       
        self.init(frame: frame)
        
        self.img = img
        self.upperTxt = upperTxt
        self.lowerTxt = lowerTxt
    }
    
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BW_GameOver", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
    }
    
    // MARK:- API
    
    func update(img: UIImage?, upperTxt: String?, lowerTxt: String?) {
        self.img = img
        self.upperTxt = upperTxt
        self.lowerTxt = lowerTxt
    }
    
    
    
    
}
