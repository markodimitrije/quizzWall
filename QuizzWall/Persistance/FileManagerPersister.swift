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
    
    func save(_ dict: [String: Any], withFilename file: String) {
        print("FileManagerPersister.save, implement me")
    }
    
    func save(_ dict: [String: Any], withFilename file: String, completionHandler: (_ success: Bool) -> () ) {
        print("FileManagerPersister.save, implement me")
        completionHandler(true)
    }
    
}
