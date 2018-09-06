//
//  BW_BrickView.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class BB_HammerView: UIView {
    
    var view: UIView!
    
    weak var delegate: BtnTapManaging?
    
    // Outlets and Actions: - start
    
    @IBOutlet weak var imgViewFirst: UIImageView!
    
    @IBOutlet weak var imgViewSecond: UIImageView!
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var elemBorderView: UIView! {
        didSet {
            formatBorderView()
        }
    }
    
    @IBOutlet weak var shadeView: UIView!
    
    @IBAction func btnIsTapped(_ sender: UIButton) {
        
        delegate?.btnTapped(sender: sender) // ne radi ama bas nista, samo javi delegate-u
        
    }
    
    
    // Outlets and Actions: - end
    
    private var imgFirst: UIImage? {
        get {
            return imgViewFirst?.image
        }
        set {
            imgViewFirst?.image = newValue
        }
    }
    
    private var imgSecond: UIImage? {
        get {
            return imgViewSecond?.image
        }
        set {
            imgViewSecond?.image = newValue
            imgViewSecond.isHidden = (newValue == nil)
        }
    }
    
    
    private var txt: String? {
        get {
            return lbl?.text
        }
        set {
            lbl?.text = newValue
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
    
    convenience init(frame: CGRect, imgFirst: UIImage?, imgSecond: UIImage?, text: String?) {
        self.init(frame: frame)
        self.imgFirst = imgFirst
        self.imgSecond = imgSecond
        self.txt = text
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BB_HammerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
    
    // MARK:- API
    
    func updateView(text: String?) {
        self.txt = text ?? ""
    }
    
    func updateView(imgFirst: UIImage?, imgSecond: UIImage?, text: String?, lblTxtColor: UIColor = .white) {
        self.imgFirst = imgFirst
        self.imgSecond = imgSecond
        self.txt = text ?? ""
        self.lbl.textColor = lblTxtColor
    }
    
    func updateView(imgFirst: UIImage?, imgSecond: UIImage?, text: String?, lblTxtColor: UIColor = .white, borderColor: UIColor?) {
        self.imgFirst = imgFirst
        self.imgSecond = imgSecond
        self.txt = text ?? ""
        self.lbl.textColor = lblTxtColor
        self.elemBorderView.layer.borderColor = borderColor?.cgColor
    }
    
    // MARK:- Privates
    
    // ova treba u protocol
    
    private func formatBorderView() {
        
        elemBorderView.layer.cornerRadius = CGFloat.init(2)
        elemBorderView.layer.borderColor = CT_LIGHT_BLUE_COLOR.cgColor
        elemBorderView.layer.borderWidth = CGFloat.init(1)
    }
    
}
