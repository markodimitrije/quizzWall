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
    
    // MARK:- Privates
    
    private func setAnswersBtns(usingLayout layout: AnswerBtnsLayout) {
        DispatchQueue.main.async {
            let axis: UILayoutConstraintAxis = (layout == AnswerBtnsLayout.twoRows) ? .horizontal : .vertical
            self.upperStackView.axis = axis
            self.lowerStackView.axis = axis
        }
    }
    
}




class InfoViewManager {
    
    weak var infoView: InfoView?
    private weak var timer: Timer?
    private var timeElapsedClosure: () -> ()?
    private var limit: Int
    private var counter: Int {
        didSet {
            updateInfoView()
        }
    }
    
    init(infoView: InfoView, timeToAnswer limit: Int, timeElapsedClosure: @escaping () -> ()?) {
        self.infoView = infoView
        self.limit = limit
        self.counter = limit
        self.timeElapsedClosure = timeElapsedClosure
        //timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(InfoViewManager.count(timer:)), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(InfoViewManager.count(timer:)), userInfo: nil, repeats: true)
    }
    
    // API
    
    func userAnswered(correctly: Bool) {
        timer?.invalidate() // zaustavi timer
        //        timer = nil - nije neophodno, invalidate implicitno zove ovaj red...
        updateInfoView()
    }
    
    func updateInfoView() {
        
        guard let user = user else {return}
        
        infoView?.set(gemsCount: user.gems, hammerCount: user.hammer, timeLeftText: "TIME LEFT:", counter: "\(counter)")
        
    }
    
    
    
    @objc func count(timer: Timer) {
        //print("count is called")
        counter = max(0, counter - 1)
        if counter == 0 {
            userAnswered(correctly: false)
            timeElapsedClosure()
        }
    }
    
    deinit { print("InfoViewManager.deinit. is called") }
}
