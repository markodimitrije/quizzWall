//
//  BW_BrickView.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class BB_TNameScoreView: UIView {
    
    var view: UIView!
    
    // Outlets and Actions: - start
    
    @IBOutlet weak var upperLbl: UILabel!
    
    @IBOutlet weak var lowerLbl: UILabel!
    
    // Outlets and Actions: - end
    
    private var upperLblText: String? {
        get {
            return upperLbl?.text
        }
        set {
            upperLbl?.text = newValue
        }
    }
    private var lowerLblText: String? {
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
    
    convenience init(frame: CGRect, upperLblText: String?, lowerLblText: String?) {
        self.init(frame: frame)
        self.upperLblText = upperLblText
        self.lowerLblText = lowerLblText
        
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BB_TNameScoreView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
    }
    
    // MARK:- API
    
    func updateView(upperLblText: String?, lowerLblText: String?) {
        self.upperLblText = upperLblText
        self.lowerLblText = lowerLblText
    }
    
    // MARK:- Privates
    
    
}
