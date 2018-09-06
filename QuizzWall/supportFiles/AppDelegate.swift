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
        
        user?.hammer = 80
        
        FirebaseApp.configure()
        
        let _ = PhoneLanguage().getPrefferedLanguage()
        
        copyResourceFromBundleIfNecessary() // ne radi copy-overwrite nego samo copy ako nema file-a tamo
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.questionsSavedOnDisk),
                                               name: NC.Name.questionsSavedOnDisk,
                                               object: nil)
        
        Networking().checkVersionsAndDownloadQuestionsIfNeeded() // ovo mora da se pozove na main-u. zasto ?
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        //print("applicationWillEnterForeground is called")
        
        Networking().checkVersionsAndDownloadQuestionsIfNeeded()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        let filename = Constants.LocalFilenames.userInfo
        FileManagerPersister().saveUser(user: user, toFile: filename, ext: "txt")
        
        nc.post(name: NC.Name.applicationDidEnterBackground, object: nil) // treba wallVC da save state
        
        //print("applicationDidEnterBackground")
        
    }
    
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        print("applicationWillTerminate")
    }
    
    @objc func questionsSavedOnDisk() {
        
        print("notification for questionsSavedOnDisk received")
        
        if user == nil {
            let newUser = User() // obrati paznju da ovaj konstruktor smes da zoves samo JEDAN JEDINI PUT !
            let filename = Constants.LocalFilenames.userInfo
            FileManagerPersister().saveUser(user: newUser, toFile: filename, ext: "txt")
            user = newUser
        }
        
    }
    
    private func copyResourceFromBundleIfNecessary() {
        
        let fsp = FileManagerPersister()
        
        fsp.copyResourceFromBundleToFileSystem(fileName: Constants.LocalFilenames.wallInfo, ext: "json")
        
    }
    
    
    
}


















