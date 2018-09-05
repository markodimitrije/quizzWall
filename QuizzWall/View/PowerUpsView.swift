//
//  PowerUpsView.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 04/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class PowerUpsView: UIView {
    
    @IBOutlet weak var fiftyFiftyView: BtnWithInlineImgImgLbl! {
        didSet {
            fiftyFiftyView.btn.tag = 0
        }
    } // 50_50

    @IBOutlet weak var doubleChoiceView: BtnWithInlineImgImgLbl! {
        didSet {
            doubleChoiceView.btn.tag = 1
        } // doubleChoise
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    // new code:
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePowerUpsUI()
    }
    
    func loadViewFromNib() {
        //        print("BtnBesideBtnView.loadViewFromNib at is CALLED")
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PowerUpsView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
    
    @objc func userCreditsChanged(_ notification: Notification) {
        print("userCreditsChanged, implement me, alpha i slicno....")
        updatePowerUpsUI()
    }
    
    
    
    // MARK: -API
    
    func updatePowerUpsUI() {
        
        DispatchQueue.main.async {
            
            self.fiftyFiftyView.set(leftImg: #imageLiteral(resourceName: "50_50"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "\(QuizzGame.cost_50_50)")
            self.doubleChoiceView.set(leftImg: #imageLiteral(resourceName: "double_choice"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "\(QuizzGame.costDoubleChoise)")
            
            guard let user = user else {return}
            
            let condition: CGFloat = user.gems > 1 ? 1 : 0.4
            
            self.fiftyFiftyView?.alpha = condition
            self.doubleChoiceView?.alpha = condition
        }
        
    }
    
}









