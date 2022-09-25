//
//  DateFormatter+Extensions.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation

extension DateFormatter {
    convenience init(locale: Locale, format: String) {
        self.init()
        self.locale = locale
        self.dateFormat = format
    }
}
