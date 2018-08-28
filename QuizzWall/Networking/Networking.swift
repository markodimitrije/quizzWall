//
//  Networking.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 28/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct Networking {
    
    // MARK: - Process od AppDelegate (na didFinishLaunching i applicationWillEnterForeground...)
    
    // 1.skini txt sa firebase_storage koji je dict sa aktuelnim verzijama za languages; npr "usa": 12, ...
    // ako je na device aktualna "usa": 11, napravi ime fajla za taj jezik i skini questions file sa firebase
    //
    
    func checkVersionsAndDownloadQuestionsIfNeeded() {
        
        ServerRequest().getQuestionsVersionsFromFirebaseStorage(completionHandler: { (dict) in
            
            guard let questionVersions = dict as? [String: Int] else {return}
            
            print("questionVersions = \(questionVersions)")
            
            let phoneLanguage = PhoneLanguage().getPrefferedLanguage() ?? Language.en.rawValue
            
//            if let needsUpdate = QuestionVersionChecker().hasNewerVersion(webVersions: questionVersions), needsUpdate {
            if let needsUpdate = QuestionVersionChecker().hasNewerVersion(webVersions: questionVersions, forLanguage: phoneLanguage), needsUpdate {
            
                print("okini zahtev da skines questions i posle ih save na storage...")
                
                ServerRequest().getQuestionsDataFromFirebaseStorage(forLanguage: phoneLanguage, completionHandler: { (data) in
                    
                    // ako imas i data i location to persist (on drive..)
                    guard let data = data,
                        let fileName = language_LocalFilenameQuestions_Info[phoneLanguage] else {
                            return // fileName gde ces da save je npr: "usaQuestions"
                    }
                    
                    FileManagerPersister().save(data, toFilename: fileName, completionHandler: { (success) in
                        if success {
                            //print("persist questions ok, now persist new versions")
                            //UserDefaultsPersister().saveDictToUserDefaults(questionVersions, atKey: "versions")
                            
                            print("persist questions ok, now persist new versions samo za skinuti language!")
                            
                            guard let val = questionVersions[phoneLanguage] else {return}
                            
                            let verByLanguage: [String: Int] = [phoneLanguage: val]
                            
                            //UserDefaultsPersister().saveDictToUserDefaults(versions, atKey: "versions")
                            UserDefaultsPersister().addSingleFlatDictToUserDefaults(verByLanguage, atKey: "versions")
                            
                        }
                    })
                    
                })
                
            }
            
        })
        
    }
    
}
