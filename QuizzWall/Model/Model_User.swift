//
//  Model_User.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 31/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

// vazno je da User-a init-ujes samo jednom, da mu posle ne bi ubio var questions
struct User: Codable {
    
    var sidsPlaced = [Int]()
    var sidsNew = [Int]()
    
    var hammer: Int // points
    var gems: Int {
        didSet {
            NotificationCenter.default.post(name: NC.Name.userCreditsChanged, object: nil)
        }
    } // points
    var points: Int // points
    var level: Int // racunska....
    
    var questionsNew = Set<String>() // ovde su inicijalno svi
    var questionsSeen = Set<String>() // ovaj ces puniti oduzimajuci iz prethodnog...
    
    init?() { // ako ga init-ujes bez params, setuj mu sva questions na false
        // zovi fajl iz filesys, prodji kroz sve questions, i za svaki id pridruzi mu False
        
        let phoneLanguage = PhoneLanguage().getPrefferedLanguage() ?? Language.en.rawValue
    
        
        guard let fileName = language_LocalFilenameQuestions_Info[phoneLanguage],
            let data = FileManagerPersister().readData(fromFilename: fileName),
            let questionStructure = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any],
            let dict = questionStructure else {return nil}
 
    
        let keys = Array(dict.keys)
        print("keys = \(keys)")
        
        questionsNew = Set(keys)
            
        hammer = 100
        gems = 2
        points = 0
        level = 1
    }
    
    func hasSticker(withSid sid: Int) -> Bool {
        return sidsPlaced.contains(sid)
    }
    
}

struct QuizzGame {
    static var cost_50_50 = 1
    static var costDoubleChoise = 1
    static var timeToPrepare: TimeInterval = 2
    static var timeToAnswer: TimeInterval = 15
    static var earnForAdMobMust = 2
    static var earnForAdMobAsked = 3
}

enum QuestionLevel {
    case easy, medium, hard
}

