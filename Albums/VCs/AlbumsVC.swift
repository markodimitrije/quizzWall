//
//  AlbumsVC.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 01/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class AlbumsVC: UIViewController {

    // tableView
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- vars
    
    var albums = [Album]() {
        didSet {
            updateUI()
        }
    } // neko ce da ti set, odavde citas data; ili ih sam fetch...
    
    // MARK:- my MV_VMs
    let albumMVVM = Album_MV_VM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlbums()
    }
    
    private func loadAlbums() { // ovde trazi svom MV_VM-u da ti dobaci ove data....
        
        albums = albumMVVM.getAlbums()
        
    }
    
    private func updateUI() {
        tableView.reloadData()
    }

}

extension AlbumsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell") as? AlbumCell else {return UITableViewCell()}
        // trazi svom MV_VM-u data za taj i taj aid
        
        // ovo mozes i na BG_QUEUE ...
        
        let album = albums[indexPath.row]
        
        let (image, name, count) = albumMVVM.getAlbumRow(for: album)
        
        cell.set(image: image, txt: name, count: count)
        
        return cell
    }
}
