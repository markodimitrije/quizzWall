//
//  VCsControlHelpers.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 05/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

struct AnswerBtnsManager {
    
    var answerBtns: [UIButton]
    var cnstrQuestionToAnswersView: NSLayoutConstraint
    var cnstrQuestionToImageView: NSLayoutConstraint
    var upperStackView: UIStackView
    var lowerStackView: UIStackView
    
    init(answerBtns: [UIButton],
         cnstrQuestionToAnswersView: NSLayoutConstraint,
         cnstrQuestionToImageView: NSLayoutConstraint,
         upperStackView: UIStackView,
         lowerStackView: UIStackView) {
        self.answerBtns = answerBtns
        self.cnstrQuestionToAnswersView = cnstrQuestionToAnswersView
        self.cnstrQuestionToImageView = cnstrQuestionToImageView
        self.upperStackView = upperStackView
        self.lowerStackView = lowerStackView
    }
    
    // API
    
    func updateWith(answers: [String]) {
        let _ = self.answerBtns.map { (btn) -> Void in
            btn.setTitle(answers[btn.tag], for: .normal)
        }
    }
    
    func formatAnswerBtns(withDelay amount: Double, questionImage: UIImage?) {
        
        delay(amount) {
            
            if let _ = questionImage { // imas question image
                self.setAnswersBtns(usingLayout: .twoRows)
                self.cnstrQuestionToAnswersView.isActive = false
                self.cnstrQuestionToImageView.isActive = true
            } else {
                self.setAnswersBtns(usingLayout: .oneColumn)
                self.cnstrQuestionToImageView.isActive = false
                self.cnstrQuestionToAnswersView.isActive = true
            }
        }
        
    }
    
    // MARK:- Prvates
    
    private func setAnswersBtns(usingLayout layout: AnswerBtnsLayout) {
        DispatchQueue.main.async {
            let axis: UILayoutConstraintAxis = (layout == AnswerBtnsLayout.twoRows) ? .horizontal : .vertical
            self.upperStackView.axis = axis
            self.lowerStackView.axis = axis
        }
    }
    
}

