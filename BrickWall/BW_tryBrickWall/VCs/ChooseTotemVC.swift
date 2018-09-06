//
//  ViewController.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class ChooseTotemVC: UIViewController {

    var json: Any? {
        didSet {
            guard let json = json else { return }
            totem = json as? CrackTotemSticker
        }
    }
    
    var totem: CrackTotemSticker? {
        didSet {
//            print("imam DATA, totem = \(String(describing: totem))")
        }
    }
    
    @IBAction func readBtnTapped(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segueShowBrickWall", sender: sender)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMyModel_AllCrests()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let btn = sender as? UIButton else { return }
        
        guard let identifier = segue.identifier, identifier == "segueShowBrickWall",
        let dvc = segue.destination as? BrickWallManaging else { return }
        
        dvc.userChoseTotemSid(btn.tag)
        
    }
    
    private func loadMyModel_AllCrests() {
        /*
        CT_NetworkingAndCoreDataManager().getAllCrestsFromBundle(successHandler: { (allData) in
        
            guard let data = allData else { return }
            
            let crackTotemSyncManager = CT_NetworkingAndCoreDataManager() // napravi na ovom THREAD-U
            
            crackTotemSyncManager.saveAllCrestsResponseToCDCrackTotem(data: data)
        
        })
        */
        print("loadMyModel_AllCrests: treba da load data iz JSON-a koji imas recimo u bundle")
        
    }
    
}


