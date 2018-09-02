//
//  AlbumVC.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 02/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class AlbumVC: UIViewController {

    var aid: Int? {
        didSet {
            if let aid = aid { loadStickers(forAid: aid)  }
        }
    }
    
    private var album_MV_VM = Album_MV_VM()
    
    override func viewDidLoad() { super.viewDidLoad()

        //loadStickers(forAid: aid)
        
    }

    private func loadStickers(forAid aid: Int?) {
        guard let aid = aid else {return}
        print("ucitaj mu stickers za odgovarajuci aid = \(aid)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AlbumVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "stickerCell", for: indexPath) as? StickerCell else {return UICollectionViewCell()}
        
        guard let aid = aid else {return cell} // vrati prazan cell ako ti fale data...
        
        let cardData = album_MV_VM.getMissingCardData(forAid: aid, indexPath: indexPath, rect: cell.bounds)
        
        guard let user = user, let sid = cardData.sid else {return cell}
        
        let placed = user.hasSticker(withSid: sid)
        
        if placed {
            cell.imgView.image = album_MV_VM.getStickerImage(forSid: sid)
        } else {
            cell.imgView.image = nil
            cell.emptyCardView.set(id: sid, image: cardData.image, name: cardData.name)
        }
        
        cell.emptyCardView.isHidden = placed
        
        return cell
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
