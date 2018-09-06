//
//  BW_BrickView.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class BB_BuyTotemView: UIView {
    
    var view: UIView!
    
    // Outlets and Actions: - start
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lbl: UILabel!
    
    @IBOutlet weak var elemBorderView: UIView! {
        didSet {
            formatBorderView()
        }
    }
    
    @IBOutlet weak var shadeView: UIView!
    
    @IBAction func btnIsTapped(_ sender: UIButton) {
        
        delegate?.btnTapped(sender: sender)
        
    }
    
    // Outlets and Actions: - end
    
    weak var delegate: BuyTotemAndHammerBtnTapManaging?
    
    private var img: UIImage? {
        get {
            return imgView?.image
        }
        set {
            imgView?.image = newValue
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
    
    convenience init(frame: CGRect, image: UIImage?, msgText: String?) {
        self.init(frame: frame)
        self.img = image
        self.txt = msgText ?? ""
        
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BB_BuyTotemView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
    }
    
    // MARK:- API
    
    func updateView(image: UIImage?, msgText: String?) {
        
        self.img = image
        self.txt = msgText ?? ""
    }
    
    // MARK:- Privates
    
    private func formatBorderView() {
        
        elemBorderView.layer.cornerRadius = CGFloat.init(2)
        elemBorderView.layer.borderColor = CT_YELLOW_GOLD_COLOR.cgColor
        elemBorderView.layer.borderWidth = CGFloat.init(1)
    }
    
    private func btnTapped() { // izmestac code
        
//        print("BB_BuyTotemView. btnTapped:javi preko delegate da je btn tapped")
//        print("BB_BuyTotemView. btnTapped: implement me")
        
    }
}
