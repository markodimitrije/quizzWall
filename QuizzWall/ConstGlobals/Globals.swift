//
//  Globals.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

let UD = UserDefaults.standard
let nc = NotificationCenter.default

var questionsLanguageFilenameInfo: [String: String] {
    return ["en" : "enQuestions",
            "it" : "itQuestions"]
}

//var user: User? // tebe treba samo jedan jedini put da pozove didFinishLaunching i da se init sa questions, gems, hammer, sids i sve ostalo....

//var user: User? {
//    get {
//        
//    }
//    set {
//        
//    }
//}

var user: User? = {
    let filename = Constants.LocalFilenames.userInfo
    return FileManagerPersister().readUser(fromFile: filename, ext: "txt")
}()
