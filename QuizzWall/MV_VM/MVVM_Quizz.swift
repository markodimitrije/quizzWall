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
    
    var missBtns = [UIButton]()
    
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
    
    mutating func getQuestionData(answerBtns: [UIButton], btnTagOptionInfo: [Int: String]) -> (qID: String, qtext: String, answers: [String], level: Int)? {
        
        guard let randomId = quizz.getRandomQuestionId(),
            let q = mvvmFileSystem.getQuestionFromDrive(atIndex: randomId) else { return nil}
        
        guard let qText = q["question"] as? String else {return nil}
        
        question = q // sacuvaj u svom VAR, trebace ti da analize kasnije answer
        
        let level = q["level"] as? Int ?? 0 // ako nemas podatak uzmi najlaksi nivo....
        
        let answers = q["answers"] as? [String: Any]
        
        let titles: [String] = answerBtns.map {
            if let answer = answers?["\($0.tag)"] as? [String: Any],
                let option = btnTagOptionInfo[$0.tag],
                let text = answer["text"] as? String {
                return (option + ": " + text)
            }
            return ""
        }
        
        return (randomId, qText, titles, level)
    }

    // imas arg viska ! (btnTagSelected)
    
    func analizeAnswer(question: [String: Any], btnTagOptionInfo: [Int: String], btns: [UIButton], btnTagSelected: Int) -> (correct: UIButton, miss: [UIButton])? {
        
        guard let correctBtn = getCorrectBtn(question: question, btns: btns) else {return nil}
        let missBtns = btns.filter { $0 != correctBtn }
        
        return (correctBtn, missBtns)
        
    }
    
    // ova radi ali hocu refactor
    
//    func analizeAnswer(question: [String: Any], btnTagOptionInfo: [Int: String], btns: [UIButton], btnTagSelected: Int) -> (correct: UIButton, miss: [UIButton])? {
//
//        let selectedKey = "\(btnTagSelected)"
//
//        guard let correctAnswer = AnswerExtractor.getCorrectAnswer(fromQuestion: question) else {return nil}
//        guard let correctKey = correctAnswer.keys.first else {return nil}
//
//        print("odgovor je tacan = \(correctKey == selectedKey)")
//
//        guard let correct = Int(correctKey) else {return nil}
//
//        guard let correctBtn: UIButton = btns.first(where: {$0.tag == correct}) else {return nil}
//        let missBtns = btns.filter { $0.tag != correct }
//
//        return (correctBtn, missBtns)
//
//    }
    
    func getMissBtnsToRemove(btns: [UIButton]) -> [UIButton]? {

        guard let question = self.question else {return nil} // sacuvao si kada si show question
        
        guard let correctBtn = getCorrectBtn(question: question, btns: btns) else {return nil}

        let missBtns = btns.filter { $0 != correctBtn }
        
        var randomMissBtns = missBtns
        
        var results = [UIButton]()
        
        for _ in 0..<btns.count/2 {
          //  print("limit = \(randomMissBtns.count)")
            
            let random = Int.random(limit: randomMissBtns.count)
            
          //  print("random = \(random)")
            
            let chosen = randomMissBtns.remove(at: random)
            
            results.append(chosen)
        }
        //print("vracam uk: \(results.count)")
        return results
 
    }
    
    private func getCorrectBtn(question: [String: Any], btns: [UIButton]) -> UIButton? {
        
        guard let correctAnswer = AnswerExtractor.getCorrectAnswer(fromQuestion: question),
            let correctKey = correctAnswer.keys.first,
            let correct = Int(correctKey),
            let correctBtn: UIButton = btns.first(where: {$0.tag == correct}) else {return nil}
        
        return correctBtn
        
    }
    
}



