//
//  MyUserDefaults.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct QuestionVersionChecker {
    
    // arg je file (dict) koji si procitao sa web-a (firebase storage...)
    func hasNewerVersion(webVersions: [String: Int]) -> Bool? {
        
        guard let savedVersions = UD.value(forKey: UserDefaultsKeys.versions) as? [String: Int] else
        {
            return true // ako nemas nista u UserDefaults, treba da se update
        }
        
        //return webVersions == savedVersions hard-coded version da uvek download
        return webVersions != savedVersions
    }
    
    func hasNewerVersion(webVersions: [String: Int], forLanguage language: String) -> Bool? {
        
        guard let savedVersions = UD.value(forKey: UserDefaultsKeys.versions) as? [String: Int] else
        {
            return true // ako nemas nista u UserDefaults, treba da se update
        }
        
        return webVersions[language] != savedVersions[language] // ako je value za taj jezik drugaciji
        
    }
    
}





struct UserDefaultsKeys {
//    struct Language {
//        static let italy = "italy"
//        static let italy = "italy"
//        static let italy = "italy"
//        static let italy = "italy"
//        static let italy = "italy"
//    }
    static let versions = "versions"
}
