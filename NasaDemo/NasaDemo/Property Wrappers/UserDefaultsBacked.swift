//
//  Storage.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation

@propertyWrapper struct UserDefaultsBacked<T> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
