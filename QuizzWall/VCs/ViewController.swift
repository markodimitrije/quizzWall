//
//  ViewController.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet var answerBtns: [UIButton]!
    
    let mvvmUserDefaults = MVVM_UserDefaults()
    let mvvmFileSystem = MVVM_FileSystem()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestionsOnUI()
    }
    
    private func loadQuestionsOnUI() {

        // language - pitaj device koja je scheme ....
        
        guard let q = mvvmFileSystem.getQuestionFromDrive(atIndex: 0) else {
            return
        }
        
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
    
    
    
}


extension ViewController {
    var btnTagOptionInfo: [Int: String] { // i ovo moze localizable "A", "B", "V", "G"... chi, ind...
        return [0: "A", 1: "B", 2: "C", 3: "D"]
    }
}
