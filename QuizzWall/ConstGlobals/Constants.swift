//
//  Constants.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Time {
        static let loadingAnimForQuestion = 2.0
    }
    
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
        
        static let userInfo = "userInfo"
        static let wallInfo = "totemOriginal"
        static let albums = "albums"
        static let stickers = "stickers"
        static let stickersInfo = "stickersInfo"
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
            
            static let filenamePrefix = "/question_"
            
        }
        
    }
    
    struct FileExtensions {
        static let jpg = "jpg"
    }
    
}

struct NC {
    struct Name {
        static let applicationDidEnterBackground = NSNotification.Name.init("applicationDidEnterBackground")
        static let questionsSavedOnDisk = NSNotification.Name.init("questionsSavedOnDisk")
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


