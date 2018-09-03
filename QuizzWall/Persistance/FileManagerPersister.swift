//
//  FileManagerPersister.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

let fm = FileManager.default

struct FileManagerPersister {
    
    func docDirPath(forFilename fileName: String, ext: String) -> URL? {
         return FileManager.documentDirectoryUrl?.appendingPathComponent(fileName).appendingPathExtension(ext)
    }
    
    func copyResourceFromBundleToFileSystem(fileName: String, ext: String) {
        
        guard let readUrl = Bundle.main.url(forResource: fileName, withExtension: ext) else { return}
        
        guard let writeUrl = FileManager.documentDirectoryUrl?.appendingPathComponent(fileName).appendingPathExtension(ext) else { return}
        
        try? FileManager.default.copyItem(at: readUrl, to: writeUrl)
    }
    
    // API je takav da posaljes DICT
    
    func save(_ dict: [String: Any],
              withFilename file: String,
              completionHandler: @escaping (_ success: Bool) -> () ) {
        
        print("FileManagerPersister.save, implement me")
        
        guard let docDirUrl = FileManager.documentDirectoryUrl else {
            completionHandler(false)
            return
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict) else {
            completionHandler(false)
            return
        }
        
        do {
            let saveUrl = docDirUrl.appendingPathComponent(file).appendingPathExtension("txt")
            try data.write(to: saveUrl)
        }
        catch {
            completionHandler(false)
            return
        }
        
        completionHandler(true)
    }

    // API je takav da posaljes Data
    
    func save(_ data: Data, toFilename file: String, completionHandler: @escaping (_ success: Bool) -> () ) {
        print("FileManagerPersister.data, implement me")
        
        // ako imas i ok podatke i lokaciju gde da save...
        guard let docDirUrl = FileManager.documentDirectoryUrl else {
            completionHandler(false)
            return
        }
        
        do {
            let saveUrl = docDirUrl.appendingPathComponent(file)
            print("saveUrl = \(saveUrl)")
            try data.write(to: saveUrl, options: .atomic)
        }
        catch {
            completionHandler(false)
            return
        }
        
        completionHandler(true)
    }
    
    // mozes ovde novu func da persist (write) jsonString....
    
    
    func readData(fromFilename file: String) -> Data? {
        
        guard let docDirUrl = FileManager.documentDirectoryUrl else { return nil }
        
        let readUrl = docDirUrl.appendingPathComponent(file)
        
        guard let data = try? Data.init(contentsOf: readUrl) else {return nil}
        
        print("FileManagerPersister.readData.data = \(data)")
        
        return data
    }
    
    /*
    func readString(fromFilename file: String) -> String? {
        
        print("FileManagerPersister.readString, implement me")
        
        guard let docDirUrl = FileManager.documentDirectoryUrl else { return nil }
        
        let readUrl = docDirUrl.appendingPathComponent(file).appendingPathExtension("txt")
        
        guard let data = try? String(contentsOf: readUrl) else {return nil}
        
        return data
    }
    */
    
    func readUser(fromFile file: String, ext: String) -> User? {
        
        guard let readUrl = self.docDirPath(forFilename: file, ext: ext) else {return nil}
        
        let decoder = JSONDecoder()
        
        guard let data = try? Data.init(contentsOf: readUrl),
            let user = try? decoder.decode(User.self, from: data) else {return nil}
        
        //print("FileManagerPersister.readData.data = \(data)")
        
        print("FileManagerPersister.readData.user = \(user)")
        
        return user
        
    }
    
    func saveUser(user: User?, toFile file: String, ext: String) { // trebao si completion handler !
        
        guard let user = user else {return }
        
        guard let url = self.docDirPath(forFilename: file, ext: ext) else {return }
        
        let encoder = JSONEncoder()
        
        guard let data = try? encoder.encode(user) else {return }
        
        print("FileManagerPersister.saveUser.data = \(data), user is saved")
        
        try? data.write(to: url)
        
    }


}
