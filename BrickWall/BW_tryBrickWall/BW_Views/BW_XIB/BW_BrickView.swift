//
//  BW_BrickView.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class BW_BrickView: UIView {
    
    var view: UIView!
    
    var cellId: Int!
    
    weak var delegate: BrickTapResponsing?

    // Outlets and Actions: - start
    
    @IBOutlet weak var btn: UIButton! {
        didSet {
            btn.titleLabel?.minimumScaleFactor = 0.8
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    @IBAction func btnTapped(_ sender: UIButton!) {
        delegate?.brickTappedAt(cellId: cellId)
    }
    
    @IBOutlet weak var tImgView: UIImageView!
    
    @IBOutlet weak var bImgView: UIImageView!
    
    @IBOutlet weak var iImgView: UIImageView!
    
    
    
    // Outlets and Actions: - end
    
    private var bImg: UIImage? {
        get {
            return bImgView?.image
        }
        set {
            bImgView?.image = newValue
        }
    }
    private var tImg: UIImage? {
        get {
            return tImgView?.image
        }
        set {
            tImgView?.image = newValue
        }
    }
    private var iImg: UIImage? {
        get {
            return iImgView?.image
        }
        set {
            iImgView?.image = newValue
        }
    }
    private var txt: String? {
        get {
            return btn?.title(for: .normal)
        }
        set {
            btn?.setTitle(newValue, for: .normal)
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
    
    convenience init(cellId: Int, frame: CGRect, bImg: UIImage?, tImg: UIImage?, iImg: UIImage?, txt: String?) {
        self.init(frame: frame)
        self.cellId = cellId // ovo je IDENTIFIER, TAG, REFERENCA
        self.tImg = tImg
        self.bImg = bImg
        self.iImg = iImg
        self.txt = txt
    }
    
    func loadViewFromNib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "BW_BrickView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
    }
    
    // MARK:- API
    
    func updateCrackImage(img: UIImage?) {
        self.iImg = img
    }
    
    func updateBrick(otk: Int, total: Int, img: UIImage?) {
        self.iImg = img
        self.txt = "\(total - otk)"
        
    }
    
    // MARK:- Privates
    
    
}
