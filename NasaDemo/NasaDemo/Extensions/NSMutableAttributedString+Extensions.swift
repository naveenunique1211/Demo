//
//  NSMutableAttributedString+Extensions.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func addForegroundColorAttribute(toSubString subString: String, foregroundColor: UIColor) {
        let range = (string as NSString).range(of: subString)
        addAttribute(.foregroundColor, value: foregroundColor, range: range)
    }
    
    func addLinkAttribute(toSubString subString: String, link: String) {
        let range = (string as NSString).range(of: subString)
        addAttribute(.link, value: link, range: range)
    }
}
