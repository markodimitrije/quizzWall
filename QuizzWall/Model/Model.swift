//
//  Model.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation




struct QuestionStructure: Codable {
    var questions: [String: Question]
}

struct Question: Codable {
    var question: String // ovo je pitanje, npr 'Koje godine je zavrsen 2. svetski rat?'
    var answers: [String: Answer] // ponudjeni odgovori
}

struct Answer: Codable {
    var text: String // "1944"  ....         // "1945"
    var correct: Bool // false  ....         // true
}


/* hocu da save ovo:
 {
    "0": {
        "question": "End of first world war was?",
        "answers": {
                         "A": {"text": "1945",
                                "correct": false},
                         "B": {"text": "1941",
                                "correct": false},
                         "C": {"text": "1918",
                                "correct": true},
                         "D": {"text": "1914",
                                "correct": false}
                    }
        }
    "1": ....
 }
 */


//struct QuestionStructure: Codable {
//    var id: String // ovo je pitanje, npr 'Koje godine je zavrsen 2. svetski rat?'
//    var question: Question // jedan Question
//}
//
//struct Question: Codable {
//    var text: String // ovo je pitanje, npr 'Koje godine je zavrsen 2. svetski rat?'
//    var answers: [AnswerOptions] // ponudjeni odgovori
//}
//
//struct AnswerOptions: Codable {
//    var id: String
//    var answer: Answer
//}
//
//struct Answer: Codable {
//    var text: String // "1944"  ....         // "1945"
//    var correct: Bool // false  ....         // true
//}
