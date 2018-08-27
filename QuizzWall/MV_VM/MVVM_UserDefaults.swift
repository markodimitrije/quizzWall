//
//  MVVM_UserDefaults.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct MVVM_UserDefaults {
    
    // treba da je lista, a ne dict
    
    func getQuestions(forLanguage language: String) -> [String: Any]? {
        return UD.value(forKey: "questions") as? [String : Any]
    }
    
    func getQuestionFromUserDefaults(atIndex index: Int) -> String? {
        
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
