//
//  Album_MV_VM.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 02/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

struct Album_MV_VM {
    
    // MARK:- API
    
    func getMissingCardData(forAid aid: Int, indexPath: IndexPath, rect: CGRect) -> (sid: Int?, image: UIImage, name: String) {
        
        var image: UIImage?
        var sid: Int?
        var name: String?
            
        if let imageName = albumHolderInfo[aid],
            let img = UIImage.init(named: imageName) {
            image = img
        }
        
        if let sids = getSids(forAid: aid) {
            sid = sids[indexPath.item]
        }
        
        if let stickerName = getStickerName(forSid: sid) {
            name = stickerName
        }
        
        return (sid, image: image ?? #imageLiteral(resourceName: "brain_1"), name: name ?? "unknown")
    }
    
    func getStickerImage(forSid sid: Int) -> UIImage? {
        return UIImage.init(named: "stickers" + "\(sid)")
    }
    
    private func getSids(forAid aid: Int) -> [Int]? {
        
        guard let albums = BundleAlbumDataProvider().getData(for: .albums) as? [Album] else {return nil}
        
        guard let album = albums.first(where: {$0.aid == aid}) else {return nil}
        
        return album.sids
    }
    
    private func getStickerName(forSid sid: Int?) -> String? {
        
        guard let sid = sid else {return nil}
        
        guard let stickers = BundleAlbumDataProvider().getData(for: .stickers) as? [Sticker] else {return nil}
        
        guard let sticker = stickers.first(where: {$0.sid == sid}) else {return nil}
        
        return sticker.name
    }
    
}
