//
//  Extensions.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentDirectoryUrl: URL? {
        return FileManager.default.urls(for: .documentationDirectory, in: .userDomainMask).first
    }
}
