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
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        print("applicationWillEnterForeground is called")
        
        Networking().checkVersionsAndDownloadQuestionsIfNeeded()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        nc.post(name: NC.Name.applicationDidEnterBackground, object: nil) // treba wallVC da save state
        
    }
    
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    private func copyResourceFromBundleIfNecessary() {
        
        let fsp = FileManagerPersister()
        
        fsp.copyResourceFromBundleToFileSystem(fileName: "totemOriginal", ext: "json")
        
    }
    
    
    
}


















