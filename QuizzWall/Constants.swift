//
//  Constants.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct Constants {
    
    struct LocalFilenames {
        struct Questions {
            static let usa = "usaQuestions"
            static let chi = "chiQuestions"
        }
    }
    
    struct Urls {
        
        static let storageRoot = "gs://testquestionsapp.appspot.com" // ovo je bucket
        
        struct Questions {
            
            static let folder = "/questions"
            
            struct Filenames {
                static let usa = "/usaQuestions.rtf"
                static let chi = "/quizQuestions.rtf"
                static let ind = "/quizQuestions.rtf"
                static let ger = "/quizQuestions.rtf"
                //static let france = "/quizQuestions.rtf"
                static let ita = "/quizQuestions.rtf"
                static let por = "/quizQuestions.rtf"
                static let spa = "/quizQuestions.rtf"
                static let rus = "/quizQuestions.rtf"
            }
            
        }
        
        struct Versions {
            
            static let folder = "/versions"
            
            static let filename = "/questionVersions.rtf"
        }
        
        struct Images {
            
            static let folder = "/images"
            
            static let filename = "/1.png"
        }
        
    }
    
    
}

enum Language: String {
    
    case usa = "usa"
    case chi = "chi"
    case ind = "ind"
    case rus = "rus"
    case ger = "ger"
    case por = "por"
    case spa = "spa"
    case ita = "ita"
    
}

var questionsLanguageFilenameInfo: [String: String] {
    return ["usa" : "usaQuestions",
            "chi" : "chiQuestions"]
}
