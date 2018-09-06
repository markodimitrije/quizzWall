//
//  CT_Model_1.swift
//  tryReadJsonFromBundle
//
//  Created by Marko Dimitrijevic on 07/03/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

struct SingleBrickInfo {
    var numOfRows: Int
    var row: Row
    var cell: Cell
}

enum CoinType {
    case gold
    case silver
}
