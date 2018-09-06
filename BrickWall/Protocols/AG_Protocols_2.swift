//
//  AG_Protocols_2.swift
//  tryJustBrickWallVC
//
//  Created by Marko Dimitrijevic on 28/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

protocol BtnTapManaging: class {
    
    func btnTapped(sender: UIButton)
    
}

extension BtnTapManaging {
    func btnTapped(sender: UIButton) {
        //        print("btn with tag: \(sender.tag) is tapped! implement me")
    }
}
