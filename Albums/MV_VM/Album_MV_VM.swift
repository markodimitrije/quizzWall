//
//  Album_MV_VM.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 01/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

struct Album_MV_VM {
    
    func getAlbums() -> [Album] {
        // ti nabavi zovuci bundle
        let albums = BundleAlbumDataProvider().getData(for: .albums) as? [Album]
        return albums ?? [ ]
    }
    
    func getAlbum(forAid aid: Int) -> Album? {
        return Album(aid: aid, name: "implement me") // implement me
    }
    
    func getAlbumRow(for album: Album) -> (image: UIImage?, txt: String?, count: Int?) {
        let count = getCount(forAid: album.aid)
        let image = getAlbumImage(forAid: album.aid)
        let name = album.name
        return (image, name, count)
    }
    
    func getAlbumImageAndCount(forAid aid: Int) -> (image: UIImage?, count: Int?) {
        let count = getCount(forAid: aid)
        let image = getAlbumImage(forAid: aid)
        return (image, count)
    }
    
    // MARK:- Privates (zove ih API)
    
    private func getAlbumImage(forAid aid: Int) -> UIImage? {
        return UIImage.init(named: "albumImage" + "\(aid)")
    }
    
    private func getCount(forAid: Int) -> Int? {
        return 24 // implement me, izracunaj za ovaj aid koliko ima stickers, koji su placed == true (tj usera pitaj....)
    }
}
