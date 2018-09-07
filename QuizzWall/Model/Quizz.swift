//
//  Quizz.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 03/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct Quizz {
    
    func getRandomQuestionId() -> String? {
        guard let user = user else {return nil}
        let ids = user.questionsNew
        //let random = Int.random(limit: 1000000)
        let random = Int.random(limit: ids.count)
        //let random = 4 // hard-coded
        return "\(random)"
    }
}

enum AnswerBtnsLayout {
    case twoRows
    case oneColumn
}
