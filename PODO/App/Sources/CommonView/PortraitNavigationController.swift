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
}
