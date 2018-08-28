//
//  UserDefaultsPersister.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct UserDefaultsPersister {
    
    func addSingleFlatDictToUserDefaults(_ dict: [String: Any], atKey key: String) {
        guard let actualDict = UD.value(forKey: key) as? [String: Any] else {return}
        guard let key = dict.keys.first, let val = dict.values.first else {return}
        var newDict = actualDict
        newDict[key] = val
    }
    
    func saveDictToUserDefaults(_ dict: [String: Any], atKey key: String) {
        UD.set(dict, forKey: key)
    }
    
    func saveToUserDefaults(_ dict: [String: Any], forKey key: String, completionHandler: (_ success: Bool) -> () ) {
        UD.set(dict, forKey: key)
        completionHandler(true)
    }
    
}
