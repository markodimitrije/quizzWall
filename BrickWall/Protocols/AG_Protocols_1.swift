//
//  AG_Protocols_1.swift
//  StickersApp
//
//  Created by Marko Dimitrijevic on 08/05/2018.
//  Copyright © 2018 Dragan Krtalic. All rights reserved.
//

import Foundation

protocol AlbumGameAssetBuying {
    
    func getSecretKey(userId: String?, sid: Int?, gold: Int?) -> String?
    
    func buyStickerForGoldCoins(token: String?, userId: String, sid: Int, gold: Int, successHandler: @escaping(_ success: Bool) -> Void)
    
    func userBoughtStickerFromAlbumGame()
    
}


extension AlbumGameAssetBuying {
    
    func getSecretKey(userId: String?, sid: Int?, gold: Int?) -> String? {
        /*
        guard let userId = userId, let sid = sid else { return nil } // mozes da nemas val jer je 10
        let gold = gold ?? AG_ASSET_GOLD_COST
        
        let calcKey = CRYPTO_KEY_BUY_AG_ASSET.replacingOccurrences(of: "_xxx_", with: "\(gold)")
        
        guard let key = (userId + "\(sid)" + calcKey).md5 else { return nil }
        
        return key
        */
        return nil // hard-coded
    }
    
    // ti samo nabavljas podatke....
    func buyStickerForGoldCoins(token: String?, userId: String, sid: Int, gold: Int, successHandler: @escaping(_ success: Bool) -> Void) {
        
        // ovde zovi manager-a ali prethodno nabavi sve params
        /*
        guard let token = token,
            let key = getSecretKey(userId: userId, sid: sid, gold: gold) else { return }
        
        AG_RequestManager().buyAsset(token: token, sid: sid, gold: gold, key: key) { (success) in
            
            successHandler(success) // samo ako imas OK povratnu informaciju od zahteva, izvrsi sta treba
            
        }
        */
        
        successHandler(false) // hard-coded
        
    }
    
    
    
    
}


