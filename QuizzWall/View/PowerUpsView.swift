//
//  PowerUpsView.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 04/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class PowerUpsView: UIView, EnableViewManaging {
    
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
        //updatePowerUpsUI(state: .powerUpLoading)
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
        updatePowerUpsUI(state: .userGemsChanged)
    }
    
    
    
    // MARK: -API
    
    func updatePowerUpsUI(state: PowerUpState) { // rename !
        
        print("updatePowerUpsUI.state = \(state)")
        
        DispatchQueue.main.async { [weak self] in
            
            switch state {
                case .powerUpLoading:
                    self?.setContent()
                    self?.updateVisibility(questionIsActive: false)
                case .userChosePowerUpBtn:
                    self?.updateVisibility(questionIsActive: true)
                case .userGemsChanged:
                    self?.updateVisibility(questionIsActive: false)
            }
            
        }
        
    }
    
    private func updateVisibility(questionIsActive: Bool) {
        
        guard let user = user else {return}
        
        var transparency: CGFloat!
        
        if questionIsActive {
            transparency = 0.4
        } else {
            transparency = user.gems >= 1 ? 1 : 0.4
        }
        
        self.isUserInteractionEnabled = (transparency == 1) ? true : false

        self.fiftyFiftyView?.alpha = transparency
        self.doubleChoiceView?.alpha = transparency
        
    }
    
    private func setContent() {
        self.fiftyFiftyView.set(leftImg: #imageLiteral(resourceName: "50_50"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "\(QuizzGame.cost_50_50)")
        self.doubleChoiceView.set(leftImg: #imageLiteral(resourceName: "double_choice"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "\(QuizzGame.costDoubleChoise)")
    }
    
}





protocol EnableViewManaging {
    func isEnabled(_ enable: Bool)
}
extension EnableViewManaging where Self: PowerUpsView {
    func isEnabled(_ enable: Bool) {
        self.isUserInteractionEnabled = enable
        self.alpha = enable ? 1.0 : 0.5
    }
}

enum PowerUpState {
    case userChosePowerUpBtn
    case powerUpLoading
    case userGemsChanged
}

