//
//  MissingSticker.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 02/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class MissingStickerView: UIView {
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var imgBtn: UIButton!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    var id: String? {
        get {
            return idLabel?.text
        }
        set {
            idLabel?.text = newValue
        }
    }
    
    var image: UIImage? {
        get {
            return imgBtn?.backgroundImage(for: .normal)
        }
        set {
            imgBtn?.setBackgroundImage(newValue, for: .normal)
        }
    }
    
    var name: String? {
        get {
            return nameLbl?.text
        }
        set {
            nameLbl?.text = newValue
        }
    }
    
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
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MissingStickerView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
    
    // MARK: -API
    
    func set(id: Int, image: UIImage?, name: String?) {
        self.id = "\(id)"
        self.image = image
        self.name = name
    }
    
}
