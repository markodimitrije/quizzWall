//
//  AlbumCell.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 01/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var albumNameLabel: UILabel!
    
    @IBOutlet weak var countBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK:- API
    
    func set(image: UIImage?, txt: String?, count: Int?) {
        imgView?.image = image
        albumNameLabel?.text = txt
        guard let count = count else {return}
        countBtn.setTitle("\(count)%", for: .normal)
    }
    
}
