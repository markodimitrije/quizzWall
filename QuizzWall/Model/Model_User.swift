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
            
        hammer = 3000
        gems = 2
        points = 0
        level = 1
    }
    
    // MARK:- API
    
    func hasSticker(withSid sid: Int) -> Bool {
        return sidsPlaced.contains(sid)
    }
    
    mutating func questionAnswered(correctly: Bool, qLevel: QuestionLevel?) {
        
        updateHammerPoints(correctly: correctly, qLevel: qLevel)
        
    }
    
    // MARK:- Privates
    
    private mutating func updateHammerPoints(correctly: Bool, qLevel: QuestionLevel?) {
        
        guard let qLevel = qLevel,
            let values = QuizzGame.questionLevelToPointsInfo[qLevel] else {return}
        
        let newPoints = correctly ? values.correct : values.wrong
        
        self.hammer += newPoints
        
    }
    
}

