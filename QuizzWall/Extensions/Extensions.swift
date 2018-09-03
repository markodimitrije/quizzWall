//
//  Extensions.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 27/08/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

extension FileManager {
    static var documentDirectoryUrl: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}

extension CGRect {
    
    static func createRect(withCenter center: CGPoint, size: CGSize) -> CGRect {
        
        let orX = center.x - size.width/2
        let orY = center.y - size.height/2
        
        return CGRect.init(origin: CGPoint.init(x: orX, y: orY), size: size)
        
    }
}

extension UIViewController {
    
    func getCenter() -> CGPoint {
        
        return CGPoint.init(x: self.view.bounds.midX, y: self.view.bounds.midY)
        
    }
}
