//
//  ServerRequest.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation
import Firebase

struct ServerRequest {
    
    let path = Constants.Urls.self
    
    func getQuestionsFromFirebaseStorage(forLanguage language: String, completionHandler: @escaping (_ dict: [String: Any]) -> ()) {
        
        let storage = Storage.storage(url: path.storageRoot)
        
        guard let filenameOnFirebase = language_LocalFilenameQuestions_Info[language] else {
            print("getQuestionsDataFromFirebaseStorage.else.nemam local name za language"); return
        }
        
        let gsReference = storage.reference(withPath: path.Questions.folder + filenameOnFirebase)
        
        gsReference.getData(maxSize: 1024 * 1024 * 1024) { data, error in
            if let error = error {
                print("an error occurred, error description = \(error.localizedDescription)")
                completionHandler([:])
            } else if let data = data {
                
                print("imam questions data, save to storage") // ... implement me
                
                guard let dict = self.getDictData(fromData: data) else {return}
                
                print("questions = \(dict)")
                
                completionHandler(dict)
                
            }
        }
        
    }
    
    func getQuestionsDataFromFirebaseStorage(forLanguage language: String, completionHandler: @escaping (_ dict: Data?) -> ()) {
        
        let storage = Storage.storage(url: path.storageRoot)
        
        guard let filenameOnFirebase = language_FirebaseFilenameQuestions_Info[language] else {
            print("getQuestionsDataFromFirebaseStorage.else.nemam local name za language"); return
        }
        
        let gsReference = storage.reference(withPath: path.Questions.folder + filenameOnFirebase)
        
        gsReference.getData(maxSize: 1024 * 1024 * 1024) { data, error in
            if let error = error {
                print("getQuestionsDataFromFirebaseStorage. an error occurred, error description = \(error.localizedDescription)")
                completionHandler(nil)
            } else if let data = data {
                
                print("imam questions data, save to storage") // ... implement me
                
                completionHandler(data)
                
            }
        }
        
    }
    
    func getQuestionsVersionsFromFirebaseStorage(completionHandler: @escaping (_ versions: [String: Any]?) -> ()) {
        
        let storage = Storage.storage(url: Constants.Urls.storageRoot)
        
        let gsReference = storage.reference(withPath: path.Versions.folder + path.Versions.filename)
        
        gsReference.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if let error = error {
                print("an error occurred, error description = \(error.localizedDescription)")
            } else if let data = data {
                
                let dict = self.getDictData(fromData: data)
                
                completionHandler(dict)

            }
        }
        
    }
    
    
    // temp func
    
    func getImagesFromFirebaseStorage(questionId: String, completionHandler: @escaping (_ image: UIImage?) -> ()) {
        
        let filename = path.Images.filenamePrefix + questionId
        
        let storage = Storage.storage(url: Constants.Urls.storageRoot)
        
        let gsReference = storage.reference(withPath: path.Images.folder + filename + "." + Constants.FileExtensions.jpg)
        
        gsReference.getData(maxSize: 1024 * 1024 * 1024) { data, error in
            if let error = error {
                print("an error occurred, error description = \(error.localizedDescription)")
                completionHandler(nil)
            } else if let data = data {
                
                completionHandler(UIImage.init(data: data))
                
                print("getImagesFromFirebaseStorage.imam imageData")
            }
        }
        
    }
    
    func getDictData(fromData data: Data) -> [String: Any]? {
        
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any] else {return nil}
        return dict
 
    }
    
}



