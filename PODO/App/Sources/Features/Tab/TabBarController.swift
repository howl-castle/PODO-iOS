//
//  TabBarController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import Then

final class TabBarController: UITabBarController {

    override var shouldAutorotate: Bool { false }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("TabBarController init Error")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoginViewIfNeeded()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let height: CGFloat = 95.0
        self.tabBar.frame.size.height = height
        self.tabBar.frame.origin.y = self.view.frame.height - height
    }

    //
    var didShow = false

    private func showLoginViewIfNeeded() {
        guard self.didShow == false else { return }
        self.didShow = true
        let viewController = SignInViewController()
        let navigationController = PortraitNavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .overFullScreen
        navigationController.isNavigationBarHidden = true
        self.present(navigationController, animated: false)
    }

    private func setupUI() {
        self.setupProperties()
        self.setupTabs()
    }

    private func setupProperties() {
        self.tabBar.barTintColor = .black2
        self.tabBar.tintColor = .white2
        self.tabBar.isTranslucent = false

        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .black2
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    private func setupTabs() {
        let homeTabViewController = self.makeHomeTabViewController()
        let expertTabViewController = self.makeExpertTabViewController()
        let revenueTabViewController = self.makeRevenueTabViewController()
        let settingTabViewController = self.makeSettingTabViewController()
        self.viewControllers = [homeTabViewController,
                                expertTabViewController,
                                revenueTabViewController,
                                settingTabViewController]
    }

    private func makeHomeTabViewController() -> UIViewController {
        let viewController = HomeViewController()
        let tabBarItem = UITabBarItem(title: "Home",
                                      image: UIImage(named: "home off"),
                                      selectedImage: UIImage(named: "home on"))
        tabBarItem.imageInsets = self.tabBarItemImageInsets
        viewController.tabBarItem = tabBarItem
        return viewController
    }

    private func makeExpertTabViewController() -> UIViewController {
        let viewController = ExpertViewController()
        let tabBarItem = UITabBarItem(title: "QnA",
                                      image: UIImage(named: "coffee off"),
                                      selectedImage: UIImage(named: "coffee on"))
        tabBarItem.imageInsets = self.tabBarItemImageInsets
        viewController.tabBarItem = tabBarItem
        return viewController
    }

    private func makeRevenueTabViewController() -> UIViewController {
        let viewController = RevenueViewController()
        let tabBarItem = UITabBarItem(title: "Revenue",
                                      image: UIImage(named: "revenue off"),
                                      selectedImage: UIImage(named: "revenue on"))
        tabBarItem.imageInsets = self.tabBarItemImageInsets
        viewController.tabBarItem = tabBarItem
        return viewController
    }

    private func makeSettingTabViewController() -> UIViewController {
        let viewController = SettingViewController()
        let tabBarItem = UITabBarItem(title: "Setting",
                                      image: UIImage(named: "setting off"),
                                      selectedImage: UIImage(named: "setting on"))
        tabBarItem.imageInsets = self.tabBarItemImageInsets
        viewController.tabBarItem = tabBarItem
        return viewController
    }

    private let tabBarItemImageInsets = UIEdgeInsets(top: .zero, left: .zero, bottom: -15.0, right: .zero)
}
