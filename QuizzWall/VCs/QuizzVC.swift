//
//  ViewController.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class QuizzVC: UIViewController {
    
    @IBOutlet weak var infoView: InfoView!
    
    @IBOutlet weak var questionLbl: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var answerBtns: [UIButton]!
    
    @IBOutlet weak var powerUpsView: PowerUpsView!
    
    @IBAction func answerBtnTapped(_ sender: UIButton) {
        answerBtnIsTapped(sender)
    }
    
    // stackView references
    
    @IBOutlet weak var upperStackView: UIStackView!
    @IBOutlet weak var lowerStackView: UIStackView!
    
    @IBOutlet weak var cnstrQuestionToImageView: NSLayoutConstraint!
    
    @IBOutlet weak var cnstrQuestionToAnswersView: NSLayoutConstraint!
    
    let mvvmUserDefaults = MVVM_UserDefaults()
    let mvvmFileSystem = MVVM_FileSystem()
    var mvvmQuizz = MVVM_Quizz()
    let quizz = Quizz()
    
    var level: Int?
    
    var answerBtnsManager: AnswerBtnsManager! // pointer na struct, ciji je arg var answerBtns: [UIButton]
    weak var infoViewManager: InfoViewManager! // pointer na class, ciji je arg weak var infoView: InfoView!
    
    weak var questionImage: UIImage? {
        didSet {
            reloadImage(questionImage, intoImageView: imageView)
            answerBtnsManager.formatAnswerBtns(withDelay: 0, questionImage: questionImage)
        }
    } // ovo treba da load sa zvanjem firebase (imas 2 sec)
    
    //var question: [String: Any]?
    
    override func viewDidLoad() { super.viewDidLoad()
        
        setMyManagerVars()
        
        loadQuestionOnUI()
        
        displayLoadingAnimation(duration: Constants.LoadingQuestionAnimation.duration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //infoViewManager.userAnswered(correctly: false)
        userAnswered(correctly: false)
    }
    
    private func setMyManagerVars() {
        
        answerBtnsManager = AnswerBtnsManager.init(answerBtns: answerBtns, cnstrQuestionToAnswersView: cnstrQuestionToAnswersView, cnstrQuestionToImageView: cnstrQuestionToImageView, upperStackView: upperStackView, lowerStackView: lowerStackView)
        
    }
//    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)
//
//
//
//    }
    
    // MARK: - configure UI with question, answers and assisstent
    
    private func loadQuestionOnUI() {

        // language - pitaj device koja je scheme ....
        
        guard let data = mvvmQuizz.getQuestionData(answerBtns: answerBtns, btnTagOptionInfo: btnTagOptionInfo) else {return} // prikazi err...
        
        questionLbl.text = data.qtext
        
        level = data.level
        
        answerBtnsManager.updateWith(answers: data.answers)
        
        ServerRequest().getImagesFromFirebaseStorage(questionId: data.qID) { [weak self] (image) in
            self?.questionImage = image
        }
        
        infoViewManager = InfoViewManager(infoView: infoView, timeToAnswer: 5) { [weak self] in
            
            self?.clearPreviosAndLoadNewQuestion(after: 0)
            
            return ()
        }
        
    }
    
    private func updateCreditsUI() {
        DispatchQueue.main.async {
            
        }
    }
    
    // od MV_VM-a trazi ovo: ..... da li je odgovor tacan ili ne ...... daj mi btn za tacan odgovor ...... daj mi btns za netacan odgovor
    
    private func answerBtnIsTapped(_ sender: UIButton) {
        
        guard let question = mvvmQuizz.question, // ovo je actual question
        let data = mvvmQuizz.analizeAnswer(question: question,
                                           btnTagOptionInfo: btnTagOptionInfo,
                                           btns: answerBtns,
                                           btnTagSelected: sender.tag) else {return} // prikazi error za fail
        
        userAnswerIs(correct: data.correct.tag == sender.tag, sender: sender, data: data)
        
    }
    
    //make wrongs hidden nakon 1 sec sa fade anim ili translation...
    // nakon 1 sec load novo question
    
    private func userAnswerIs(correct: Bool, sender: UIButton, data: (correct: UIButton, miss: [UIButton])) {
        
        print("userAnswerIs called")
        
        //infoViewManager.userAnswered(correctly: correct)
        
        userAnswered(correctly: correct)
        
        let _ = answerBtns.map {$0.isUserInteractionEnabled = false}
        
        sender.backgroundColor = correct ? .green : .red

        UIView.animate(withDuration: Constants.AnswerBtnsAnimation.fadingDuration,
                       delay: Constants.AnswerBtnsAnimation.delay,
                       options: .curveLinear,
                       animations: {
                            let _ = data.miss.map {$0.alpha = 0}
                            data.correct.backgroundColor = .green
                            }) { (success) in
                                self.clearPreviosAndLoadNewQuestion(after: Constants.LoadingQuestionAnimation.delay)
        }
    }
    
    private func userAnswered(correctly: Bool) {
        
        guard let level = level else {return}
        
        user?.questionAnswered(correctly: correctly, qLevel: questionLevelInfo[level])
        
        infoViewManager?.userAnswered(correctly: correctly)
        
    }
    
    // ovo je start process
    
    private func clearPreviosAndLoadNewQuestion(after: Double) {
        delay(after, closure: { [weak self] in
            self?.cleanUpAfterPreviousQuestion()
            self?.loadQuestionOnUI()
            self?.displayLoadingAnimation(duration: Constants.Time.loadingAnimForQuestion)
        })
    }

    private func cleanUpAfterPreviousQuestion() {
        let _ = answerBtns.map {
            $0.isUserInteractionEnabled = true;
            $0.alpha = 1
            $0.backgroundColor = .lightGray
            questionImage = nil
        }
    }
    
    private func reloadImage(_ image: UIImage?, intoImageView imageView: UIImageView) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
        }
    }
    
    deinit {
        print("QuizzVC.deinit is called")
    }
    
}

extension QuizzVC: LoadingAnimationManaging {}

extension QuizzVC {
    var btnTagOptionInfo: [Int: String] { // i ovo moze localizable "A", "B", "V", "G"... chi, ind...
        return [0: "A", 1: "B", 2: "C", 3: "D", 4: "E", 5: "F", 6: "G", 7: "H"]
    }
}





class RoundedBtn: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = CGFloat.init(5)
    }
}






class InfoViewManager {
    
    weak var infoView: InfoView?
    weak var timer: Timer?
    var timeElapsedClosure: () -> ()?
    var limit: Int
    var counter: Int {
        didSet {
            updateInfoView()
        }
    }
    
    init(infoView: InfoView, timeToAnswer limit: Int, timeElapsedClosure: @escaping () -> ()?) {
        self.infoView = infoView
        self.limit = limit
        self.counter = limit
        self.timeElapsedClosure = timeElapsedClosure
        //timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(InfoViewManager.count(timer:)), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(InfoViewManager.count(timer:)), userInfo: nil, repeats: true)
    }
    
    // API
    
    func userAnswered(correctly: Bool) {
        timer?.invalidate() // zaustavi timer
//        timer = nil - nije neophodno, invalidate implicitno zove ovaj red...
        updateInfoView()
    }
    
    func updateInfoView() {
        
        guard let user = user else {return}
        
        infoView?.set(gemsCount: user.gems, hammerCount: user.hammer, timeLeftText: "TIME LEFT:", counter: "\(counter)")
        
    }
    
    @objc func count(timer: Timer) {
        //print("count is called")
        counter = max(0, counter - 1)
        if counter == 0 {
            userAnswered(correctly: false)
            timeElapsedClosure()
        }
    }
    
    deinit { print("InfoViewManager.deinit. is called") }
}




