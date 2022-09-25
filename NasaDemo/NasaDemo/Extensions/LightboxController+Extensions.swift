//
//  LightboxController+Extensions.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation
import Lightbox

extension LightboxController {
    convenience init(image: UIImage) {
        self.init(images: [LightboxImage(image: image)])
        modalPresentationStyle = .fullScreen
        dynamicBackground = true
    }
}
