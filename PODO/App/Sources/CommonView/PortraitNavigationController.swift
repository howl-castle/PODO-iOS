//
//  PortraitNavigationController.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit

final class PortraitNavigationController: UINavigationController {

    override var shouldAutorotate: Bool { false }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.isNavigationBarHidden = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
