//
//  Struct MVVM_FileSystem.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct MVVM_FileSystem {
    
    func getQuestionFromDrive(atIndex index: Int, forLanguage language: Language) -> String? {
        
        guard let filename = questionsLanguageFilenameInfo[language.rawValue],
            let data = FileManagerPersister().readData(fromFilename: filename) else {return nil}
        
        guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let questions = json as? [String: Any]  else {return nil}
        
        guard let dict = questions["\(index)"] as? [String: Any],
            let q = dict["question"] as? String else {
                return nil
        }
        
        return q
        //return dict
    }
    
}
