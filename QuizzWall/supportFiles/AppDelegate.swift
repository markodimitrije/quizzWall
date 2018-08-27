//
//  AppDelegate.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 26/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        checkVersionsAndDownloadQuestionsIfNeeded() // ovo mora da se pozove na main-u. zasto ?
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("applicationWillEnterForeground is called")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func checkVersionsAndDownloadQuestionsIfNeeded() {
     
        ServerRequest().getQuestionsVersionsFromFirebaseStorage(completionHandler: { (dict) in
            
            guard let questionVersions = dict as? [String: Int] else {return}
            
            print("questionVersions = \(questionVersions)")
            
            if let needsUpdate = QuestionVersionChecker().hasNewerVersion(webVersions: questionVersions), needsUpdate {

                print("okini zahtev da skines questions i posle ih save na storage...")

                //ServerRequest().getQuestionsFromFirebaseStorage(forLanguage: Constants.Urls.Questions.Filenames.usa) // radi ali nije async...
                
                // u callback-u sacuvaj i versions i fajlove sa questions
                
                ServerRequest().getQuestionsFromFirebaseStorage(forLanguage: Constants.Urls.Questions.Filenames.usa, completionHandler: { (questions) in
                    
                    // ovde zovi filesistem persister, pa u njegovom handler-u (on success),
                    // sacuvaj verisons dict
                    
                    // ovde treba FilePersister... svoj Codable/Decodable na file sistem...
                    
                    // za sada cu i njega u UserDefaults
                    
                    UserDefaultsPersister().saveDictToUserDefaults(questions, atKey: "questions")
                    
                    
                    
                    UserDefaultsPersister().saveToUserDefaults(questions, forKey: Language.usa.rawValue,  completionHandler: { (success) in
                        
                        UserDefaultsPersister().saveDictToUserDefaults(questionVersions, atKey: "versions")
                        
                    })
                    
                })

            }
            
        })
        
        
        
        
        
    }
    
    
    
}
