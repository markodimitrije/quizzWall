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
    
}
