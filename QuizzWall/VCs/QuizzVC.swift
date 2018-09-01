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
            infoView.set(gemsCount: 12, hammerCount: 136, timeLeftText: "TIME  LEFT:", counter: "14")
        }
    }
    
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet var answerBtns: [UIButton]!
    
    @IBOutlet weak var fiftyFiftyView: BtnWithInlineImgImgLbl!
    
    @IBOutlet weak var doubleChoiceView: BtnWithInlineImgImgLbl!
    
    
    
    let mvvmUserDefaults = MVVM_UserDefaults()
    let mvvmFileSystem = MVVM_FileSystem()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestionsOnUI()
        updateAssistentUI()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    // MARK: - configure UI with question, answers and assisstent
    
    private func loadQuestionsOnUI() {

        // language - pitaj device koja je scheme ....
        
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
        
    }
    
    private func updateAssistentUI() {
        DispatchQueue.main.async {
            self.fiftyFiftyView.set(leftImg: #imageLiteral(resourceName: "50_50"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "hc1")
            self.doubleChoiceView.set(leftImg: #imageLiteral(resourceName: "double_choice"), rightImg: #imageLiteral(resourceName: "gem_1"), text: "hc1")
        }
    }
    
    private func updateCreditsUI() {
        DispatchQueue.main.async {
            
        }
    }
    
}


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
