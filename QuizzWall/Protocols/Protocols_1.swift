//
//  Protocols_1.swift
//  QuizzWall
//
//  Created by Marko Dimitrijevic on 03/09/2018.
//  Copyright © 2018 Marko Dimitrijevic. All rights reserved.
//

import UIKit

protocol LoadingAnimationManaging {
    func displayLoadingAnimation()
}

extension LoadingAnimationManaging where Self: UIViewController {
    func displayLoadingAnimation() {
        let center = self.getCenter()
        let rect = CGRect.createRect(withCenter: center, size: CGSize.init(width: 100, height: 100))
        let loadingView = UIView.init(frame: self.view.bounds); loadingView.backgroundColor = .black
        let spinnerView = SpinnerView.init(frame: rect)
        loadingView.addSubview(spinnerView)
        loadingView.tag = 11
        self.view.addSubview(loadingView)
    }
}
