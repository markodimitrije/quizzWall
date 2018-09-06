//
//  File.swift
//  StickersApp
//
//  Created by Marko Dimitrijevic on 07/06/2018.
//  Copyright © 2018 Dragan Krtalic. All rights reserved.
//

import Foundation

protocol TotemStateUpdating: class {
    func updateStateFor(crackTotemSticker: CrackTotemSticker?)
}
