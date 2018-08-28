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
            static let en = "enQuestions"
            static let zh = "zhQuestions"
            static let hi = "hiQuestions"
            static let ru = "ruQuestions"
            static let de = "deQuestions"
            static let es = "esQuestions"
            static let pt = "ptQuestions"
            static let it = "itQuestions"
        }
    }
    
    struct Urls {
        
        static let storageRoot = "gs://testquestionsapp.appspot.com" // ovo je bucket
        
        struct Questions {
            
            static let folder = "/questions"
            
            struct Filenames {
                static let en = "/enQuestions.rtf"
                static let zh = "/zhQuestions.rtf"
                static let hi = "/hiQuestions.rtf"
                static let ru = "/ruQuestions.rtf"
                static let de = "/deQuestions.rtf"
                static let pt = "/ptQuestions.rtf"
                static let es = "/esQuestions.rtf"
                static let it = "/itQuestions.rtf"
                //static let france = "/fraQuestions.rtf"
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
    
    case en = "en"
    case zh = "zh"
    case hi = "hi"
    case ru = "ru"
    case de = "de"
    case pt = "pt"
    case es = "es"
    case it = "it"
    
}

var questionsLanguageFilenameInfo: [String: String] {
    return ["en" : "enQuestions",
            "it" : "itQuestions"]
}
