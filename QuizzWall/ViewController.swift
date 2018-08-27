//
//  ViewController.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    @IBAction func btnTapped(_ sender: UIButton) {
        loadQuestionsOnUI()
    }
    
    let mvvmUserDefaults = MVVM_UserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadQuestionsOnUI() {
        
        textView.text = getQuestion(atIndex: 0) ?? "no question at the moment, try again later..."

    }
    
    private func getQuestion(atIndex index: Int) -> String? {
        
        if let questions = UD.value(forKey: "questions") as? [String: Any] {
            
//            print("getQuestion.questions = \(questions)")
            
            guard let dict = questions["\(index)"] as? [String: Any],
                let q = dict["question"] as? String else {
                    return nil
                }
            
            return q
        }
        
        return nil
    }
    
}


