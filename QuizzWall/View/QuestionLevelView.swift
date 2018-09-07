//
//  QuestionLevelView.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 06/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class QuestionLevelView: UIView {
    
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var leftView: QuestionOptionView!
    
    @IBOutlet weak var rightView: QuestionOptionView!
    
    var btnTxt: String? {
        get {
            return btn.currentTitle
        }
        set {
            btn.setTitle(newValue, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        //        print("BtnBesideBtnView.loadViewFromNib at is CALLED")
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "QuestionLevelView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(view)
        
    }
    
}

class QuestionOptionViewManager: QuestionLevelView {
    
    func update(questionLevel: Int) {
        
        btnTxt = "\(questionLevel)"
        
        leftView.update(questionLevel: questionLevel, result: .miss)
        
        rightView.update(questionLevel: questionLevel, result: .guess)
        
    }
    
    
}
