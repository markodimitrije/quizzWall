//
//  PrefferedLanguage.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 28/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

// fra je fr...

import Foundation

struct PhoneLanguage {
    
    func getPrefferedLanguage() -> String? {
        print("NSLocale.current.languageCode = \(String(describing: NSLocale.current.languageCode))")
        return NSLocale.current.languageCode
    }
    
}

var language_FirebaseFilenameQuestions_Info: [String: String] {
    return ["en": Constants.Urls.Questions.Filenames.en,
            "zh": Constants.Urls.Questions.Filenames.zh,
            "hi": Constants.Urls.Questions.Filenames.hi,
            "ru": Constants.Urls.Questions.Filenames.ru,
            "de": Constants.Urls.Questions.Filenames.de,
            "pt": Constants.Urls.Questions.Filenames.pt,
            "es": Constants.Urls.Questions.Filenames.es,
            "it": Constants.Urls.Questions.Filenames.it
    ]
}
//Constants.LocalFilenames.Questions.it

var language_LocalFilenameQuestions_Info: [String: String] {
    return ["en": Constants.LocalFilenames.Questions.en,
            "zh": Constants.LocalFilenames.Questions.zh,
            "hi": Constants.LocalFilenames.Questions.hi,
            "ru": Constants.LocalFilenames.Questions.ru,
            "de": Constants.LocalFilenames.Questions.de,
            "pt": Constants.LocalFilenames.Questions.pt,
            "es": Constants.LocalFilenames.Questions.es,
            "it": Constants.LocalFilenames.Questions.it
    ]
}
