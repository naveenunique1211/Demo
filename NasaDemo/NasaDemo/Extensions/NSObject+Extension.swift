//
//  NSObjectExtension.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation

extension NSObject {
    
    class var nameOfClass: String {
        return String(describing: self)
    }
    
    var nameOfClass: String {
        return type(of: self).nameOfClass
    }
    
}
