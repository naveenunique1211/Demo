//
//  UIEdgeInsetsExtension.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import UIKit

extension UIEdgeInsets {
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window {
                return window.safeAreaInsets
            }
        }
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    static var safeAreaTop: CGFloat {
        return safeAreaInsets.top
    }

    static var safeAreaBottom: CGFloat {
        return safeAreaInsets.bottom
    }

    static var safeAreaLeft: CGFloat {
        return safeAreaInsets.left
    }

    static var safeAreaRight: CGFloat {
        return safeAreaInsets.right
    }
}
