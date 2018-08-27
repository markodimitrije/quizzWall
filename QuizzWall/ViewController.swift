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
    
    @IBAction func btnTapped(_ sender: UIButton) {
        loadQuestionsOnUI()
    }
    
    let mvvmUserDefaults = MVVM_UserDefaults()
    let mvvmFileSystem = MVVM_FileSystem()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                let text = answer["text"] as? String {
                $0.setTitle(text, for: .normal)
            }
        }
        
    }
    
    
    
}


