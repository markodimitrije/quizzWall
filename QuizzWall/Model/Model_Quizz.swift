//
//  Model_Quizz.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 05/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

struct QuizzGame {
    static var cost_50_50 = 1
    static var costDoubleChoise = 1
    static var timeToPrepare: TimeInterval = 2
    static var timeToAnswer: TimeInterval = 15
    static var earnForAdMobMust = 2
    static var earnForAdMobAsked = 3
    
    static var questionLevelToPointsInfo: [QuestionLevel: QuestionPointsInfo] = {
        let pointsEasyQuestion = QuestionPointsInfo.init(correct: 3, wrong: -1)
        let pointsMediumQuestion = QuestionPointsInfo.init(correct: 5, wrong: -2)
        let pointsHardQuestion = QuestionPointsInfo.init(correct: 10, wrong: -3)
        return [.easy: pointsEasyQuestion, .medium: pointsMediumQuestion, .hard: pointsHardQuestion]
    }()
}

enum QuestionLevel: Int {
    case easy = 0
    case medium = 1
    case hard = 2
}

struct QuestionPointsInfo {
    var correct: Int
    var wrong: Int
}

var questionLevelInfo: [Int: QuestionLevel] {
    return [0: .easy, 1: .medium, 2: .hard]
}
