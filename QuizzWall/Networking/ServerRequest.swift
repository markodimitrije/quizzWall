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
    
    // ovo radi lepo ali mi treba da ima callback...
    
//    func getQuestionsFromFirebaseStorage(forLanguage language: String) {
//
//        let storage = Storage.storage(url: path.storageRoot)
//
//        let gsReference = storage.reference(withPath: path.Questions.folder + language)
//
//        gsReference.getData(maxSize: 1024 * 1024 * 1024) { data, error in
//            if let error = error {
//                print("an error occurred, error description = \(error.localizedDescription)")
//            } else {
//                print("imam data, save to storage") // ... implement me
//            }
//        }
//
//    }
    
    func getQuestionsFromFirebaseStorage(forLanguage language: String, completionHandler: @escaping (_ dict: [String: Any]) -> ()) {
        
        let storage = Storage.storage(url: path.storageRoot)
        
        guard let filenameOnFirebase = language_LocalFilenameQuestions_Info[language] else {
            print("getQuestionsDataFromFirebaseStorage.else.nemam local name za language"); return
        }
        
        let gsReference = storage.reference(withPath: path.Questions.folder + filenameOnFirebase)
        
        //let gsReference = storage.reference(withPath: path.Questions.folder + language)
        
        gsReference.getData(maxSize: 1024 * 1024 * 1024) { data, error in
            if let error = error {
                print("an error occurred, error description = \(error.localizedDescription)")
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
                print("an error occurred, error description = \(error.localizedDescription)")
            } else if let data = data {
                print("imam questions data, save to storage") // ... implement me
                
                guard let dict = self.getQuestionsData(fromData: data) else {return}
                
                print("questions = \(dict)")
                
                completionHandler(dict)
                
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
    
    func getImagesFromFirebaseStorage(completionHandler: @escaping (_ image: UIImage?) -> ()) {
        
        let storage = Storage.storage(url: Constants.Urls.storageRoot)
        
        let gsReference = storage.reference(withPath: path.Images.folder + path.Images.filename)
        
        gsReference.getData(maxSize: 1024 * 1024 * 1024) { data, error in
            if let error = error {
                print("an error occurred, error description = \(error.localizedDescription)")
            } else if let data = data {
                
                completionHandler(UIImage.init(data: data))
                
                print("imam imageData")
            }
        }
        
    }
    
    
    // budz... kako da sa servera dobijem samo data, a ne format fajla i sve ostalo...
    
    func getDictData(fromData data: Data) -> [String: Any]? {
        
        guard let utf8 = String.init(data: data, encoding: String.Encoding.utf8) as NSString? else {return nil}
        
        let components = utf8.components(separatedBy: "fs24")
        
        guard let data = components.last as NSString? else {return nil}
        
        let myContent = data.substring(from: 5) // imam ovako nesto: ...f0\\fs24 \\cf2 ...usefulData
        
        let content = myContent.replacingOccurrences(of: "}}", with: "}").replacingOccurrences(of: "\\", with: "")
        
        var result: [String: Any]?
        
        if let data = content.data(using: .utf8) {
            do {
                result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return result
    }
    
    func getQuestionsData(fromData data: Data) -> Data? {
        
        guard let utf8 = String.init(data: data, encoding: String.Encoding.utf8) as NSString? else {return nil}
        
        let components = utf8.components(separatedBy: "fs24")
        
        guard let data = components.last as NSString? else {return nil}
        
        let myContent = data.substring(from: 5) // imam ovako nesto: ...f0\\fs24 \\cf2 ...usefulData
        
        let content = myContent.replacingOccurrences(of: "}}", with: "}").replacingOccurrences(of: "\\", with: "")
        
        return content.data(using: .utf8)
    }
    
}



