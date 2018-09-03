//
//  ViewController.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class QuizzVC: UIViewController {
    
    @IBOutlet weak var infoView: InfoView! {
        didSet {
            guard let user = user else {return}
            infoView.set(gemsCount: user.gems, hammerCount: user.hammer, timeLeftText: "TIME LEFT:", counter: "14")
        }
    }
    
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var answerBtns: [UIButton]!
    
    @IBOutlet weak var fiftyFiftyView: BtnWithInlineImgImgLbl!
    
    @IBOutlet weak var doubleChoiceView: BtnWithInlineImgImgLbl!
    
    // stackView references
    
    @IBOutlet weak var upperStackView: UIStackView!
    @IBOutlet weak var lowerStackView: UIStackView!
    
    @IBOutlet weak var cnstrQuestionToImageView: NSLayoutConstraint!
    
    @IBOutlet weak var cnstrQuestionToAnswersView: NSLayoutConstraint!
    
    let mvvmUserDefaults = MVVM_UserDefaults()
    let mvvmFileSystem = MVVM_FileSystem()
    
    var questionImage: UIImage? // ovo treba da load sa zvanjem firebase (imas 2 sec)
    
    override func viewDidLoad() { super.viewDidLoad()
        loadQuestionsOnUI()
        updateAssistentUI()
        self.displayLoadingAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
        
        delay(Constants.Time.loadingAnimForQuestion) { [weak self] in
            self?.view.subviews.first(where: {$0.tag == 11})?.removeFromSuperview()
            self?.imageView.image = self?.questionImage
            if let _ = self?.questionImage { // imas question image
                self?.setAnswersInTwoColumns()
                self?.cnstrQuestionToAnswersView.isActive = false
                self?.cnstrQuestionToImageView.isActive = true
            } else {
                self?.setAnswersInOneColumn()
                self?.cnstrQuestionToImageView.isActive = false
                self?.cnstrQuestionToAnswersView.isActive = true
            }
        }
        
    }
    
    // MARK: - configure UI with question, answers and assisstent
    
    private func loadQuestionsOnUI() {

        // language - pitaj device koja je scheme ....
        
        //hard-coded je 0 umesto random id koji nije u userovim answers 
        
        guard let q = mvvmFileSystem.getQuestionFromDrive(atIndex: 0) else { return }
        
        questionLbl.text = q["question"] as? String
        
        let answers = q["answers"] as? [String: Any]
        
        let _ = answerBtns.map {
            if let answer = answers?["\($0.tag)"] as? [String: Any],
                let option = btnTagOptionInfo[$0.tag],
                let text = answer["text"] as? String {
                $0.setTitle(option + ": " + text, for: .normal)
            }
        }
        
        ServerRequest().getImagesFromFirebaseStorage(questionId: 0) { (image) in
            DispatchQueue.main.async { [weak self] in
                self?.questionImage = image
            }
            
        }
        
    }
    
    private func updateAssistentUI() {
        DispatchQueue.main.async {
            
            self.fiftyFiftyView.set(leftImg: #imageLiteral(resourceName: "50_50"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "\(QuizzGame.cost_50_50)")
            self.doubleChoiceView.set(leftImg: #imageLiteral(resourceName: "double_choice"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "\(QuizzGame.costDoubleChoise)")
            
            guard let user = user else {return}
            
            let condition: CGFloat = user.gems > 0 ? 1 : 0.4
            
            self.fiftyFiftyView.alpha = condition
            self.doubleChoiceView.alpha = condition
        }
    }
    
    private func updateCreditsUI() {
        DispatchQueue.main.async {
            
        }
    }
    
    // MARK: - layout operations
    
    
    private func setAnswersInOneColumn() {
        DispatchQueue.main.async { [weak self] in
            self?.upperStackView.axis = .vertical
            self?.lowerStackView.axis = .vertical
        }
    }
    
    private func setAnswersInTwoColumns() {
        DispatchQueue.main.async { [weak self] in
            self?.upperStackView.axis = .horizontal
            self?.lowerStackView.axis = .horizontal
        }
    }

    
}

extension QuizzVC: LoadingAnimationManaging {}

extension QuizzVC {
    var btnTagOptionInfo: [Int: String] { // i ovo moze localizable "A", "B", "V", "G"... chi, ind...
        return [0: "A", 1: "B", 2: "C", 3: "D"]
    }
}

class RoundedBtn: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = CGFloat.init(5)
    }
}


