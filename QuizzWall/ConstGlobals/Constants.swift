//
//  Constants.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct Constants {
    
    struct LoadingQuestionAnimation {
        static let delay = 1.0
        static let duration = 1.5
    }
    
    struct AnswerBtnsAnimation {
        static let delay = 1.0
        static let fadingDuration = 1.0
    }
    
    
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
                static let en = "/enQuestions.txt"
                static let zh = "/zhQuestions.txt"
                static let hi = "/hiQuestions.txt"
                static let ru = "/ruQuestions.txt"
                static let de = "/deQuestions.txt"
                static let pt = "/ptQuestions.txt"
                static let es = "/esQuestions.txt"
                static let it = "/itQuestions.txt"
                //static let france = "/fraQuestions.txt"
            }
            
        }
        
        struct Versions {
            
            static let folder = "/versions"
            
            static let filename = "/questionVersions.txt"
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
        static let userCreditsChanged = NSNotification.Name.init("userCreditsChanged")
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


