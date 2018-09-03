//
//  Struct MVVM_FileSystem.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct MVVM_FileSystem {
    
    var questionStructure: [String: Any]?
    
    init() {

        let docDirUrl = FileManager.documentDirectoryUrl

        let language = PhoneLanguage().getPrefferedLanguage() ?? Language.en.rawValue

        guard let filename = questionsLanguageFilenameInfo[language],
            let readUrl = docDirUrl?.appendingPathComponent(filename),
            let data = try? Data.init(contentsOf: readUrl) else {
                return
        }
        
        do {
            questionStructure = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
        } catch {
            print("MVVM_FileSystem.init.catch called")
        }
        
    }
    
    // API
    
    func getQuestionFromDrive(atIndex index: String) -> [String: Any]? {
        
        guard let structure = questionStructure else { return nil } // mozes i neki backUp u bundle...
        
        return structure[index] as? [String: Any]
        
    }
    
}
