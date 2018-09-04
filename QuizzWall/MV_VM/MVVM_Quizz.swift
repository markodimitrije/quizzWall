//
//  MVVM_Quizz.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 04/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

struct MVVM_Quizz {
    
    let mvvmUserDefaults = MVVM_UserDefaults()
    let mvvmFileSystem = MVVM_FileSystem()
    let quizz = Quizz()
    
    var question: [String: Any]? // ovde sacuvaj poslednje pitanje koje ti je neko trazio (QuizzVC)
    
    struct AnswerExtractor {
        static func getCorrectAnswer(fromQuestion question: [String: Any]) -> [String: Any]? {
            guard let answers = question["answers"] as? [String: Any] else {return nil}
            let keys = answers.keys
            var result: [String: Any]?
            for key in keys {
                if let answer = answers[key] as? [String: Any],
                    let correct = answer["correct"] as? Bool, correct {
                    result = [key: answer]
                    break
                }
            }
            return result
        }
    }
    
    mutating func getQuestionData(answerBtns: [UIButton], btnTagOptionInfo: [Int: String]) -> (qID: String, qtext: String, answers: [String])? {
        
        guard let randomId = quizz.getRandomQuestionId(),
            let q = mvvmFileSystem.getQuestionFromDrive(atIndex: randomId) else { return nil}
        
        guard let qText = q["question"] as? String else {return nil}
        
        question = q // sacuvaj u svom VAR, trebace ti da analize kasnije answer
        
        let answers = q["answers"] as? [String: Any]
        
        let titles: [String] = answerBtns.map {
            if let answer = answers?["\($0.tag)"] as? [String: Any],
                let option = btnTagOptionInfo[$0.tag],
                let text = answer["text"] as? String {
                return (option + ": " + text)
            }
            return ""
        }
        
        return (randomId, qText, titles)
    }
    
//    func analizeAnswer(question: [String: Any], btnTagOptionInfo: [Int: String], btns: [UIButton], btnTagSelected: Int) -> (correct: Int, miss: [Int])? {
//
//        let tags = btns.map {$0.tag}
//        let selectedKey = "\(btnTagSelected)"
//
//        guard let correctAnswer = AnswerExtractor.getCorrectAnswer(fromQuestion: question) else {return nil}
//        guard let correctKey = correctAnswer.keys.first else {return nil}
//
//        print("odgovor je tacan = \(correctKey == selectedKey)")
//
//        guard let correct = Int(correctKey) else {return nil}
//        let wrong = btns.filter { $0.tag != correct }.map {$0.tag}
//
//        print("correct = \(correct), miss = \(wrong)")
//
//        return (correct, wrong)
//
//    }

    func analizeAnswer(question: [String: Any], btnTagOptionInfo: [Int: String], btns: [UIButton], btnTagSelected: Int) -> (correct: UIButton, miss: [UIButton])? {
        
        let tags = btns.map {$0.tag}
        let selectedKey = "\(btnTagSelected)"
        
        guard let correctAnswer = AnswerExtractor.getCorrectAnswer(fromQuestion: question) else {return nil}
        guard let correctKey = correctAnswer.keys.first else {return nil}
        
        print("odgovor je tacan = \(correctKey == selectedKey)")
        
        guard let correct = Int(correctKey) else {return nil}
        
        guard let correctBtn: UIButton = btns.first(where: {$0.tag == correct}) else {return nil}
        let missBtns = btns.filter { $0.tag != correct }
        
        return (correctBtn, missBtns)
        
    }
    
}



