//
//  TabBarViewController.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import UIKit

protocol ScrollableViewController: UIViewController {
    func scrollToTop()
}

class TabBarViewController: UITabBarController {
    
    /// Previous selected view controller
    private var previousSelectedViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        previousSelectedViewController = selectedViewController
    }
}

// MARK: UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == previousSelectedViewController, let navigationController = viewController as? UINavigationController, let viewController = navigationController.topViewController as? ScrollableViewController {
                viewController.scrollToTop()
            }
        previousSelectedViewController = viewController
        return true
    }
}
