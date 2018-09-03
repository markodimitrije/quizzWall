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
        
        let _ = PhoneLanguage().getPrefferedLanguage()
        
        copyResourceFromBundleIfNecessary() // ne radi copy-overwrite nego samo copy ako nema file-a tamo
        
        Networking().checkVersionsAndDownloadQuestionsIfNeeded() // ovo mora da se pozove na main-u. zasto ?
        
        if user == nil {
            if let newUser = User() {
                let filename = Constants.LocalFilenames.userInfo
                FileManagerPersister().saveUser(user: newUser, toFile: filename, ext: "txt")
            }
        }
        
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
    
    private func copyResourceFromBundleIfNecessary() {
        
        let fsp = FileManagerPersister()
        
        fsp.copyResourceFromBundleToFileSystem(fileName: Constants.LocalFilenames.wallInfo, ext: "json")
        
    }
    
    
    
}


















