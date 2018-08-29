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
