//
//  LblLblBtnView.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 06/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class LblLblBtnView: UIView {
    
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var leftLbl: UILabel!
    
    @IBOutlet weak var rightLbl: UILabel!
    
    var leftTxt: String? {
        get {
            return leftLbl.text
        }
        set {
            leftLbl.text = newValue
        }
    }
    
    var rightTxt: String? {
        get {
            return rightLbl.text
        }
        set {
            rightLbl.text = newValue
        }
    }
    
    var image: UIImage? {
        get {
            return btn.backgroundImage(for: .normal)
        }
        set {
            btn.setBackgroundImage(newValue, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    func loadViewFromNib() {
        //        print("BtnBesideBtnView.loadViewFromNib at is CALLED")
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LblLblBtnView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
    
}

class QuestionOptionView: LblLblBtnView {
    
    func update(questionLevel: Int, result: QuestionResult) {
        
        guard let qLevel = questionLevelInfo[questionLevel],
            let pointsInfo = QuizzGame.questionLevelToPointsInfo[qLevel] else {return}
        
        let points = (result == .guess) ? pointsInfo.correct : pointsInfo.wrong
        
        rightTxt = "\(points)"
        
        leftTxt = (result == .guess) ? "GUESS" : "MISS"
        
    }
    
}






