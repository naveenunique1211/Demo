//
//  Date+Extensions.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .day) == .orderedSame
    }
    
    var isYesterday: Bool {
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            fatalError("Unable to calculate date by substracting 1 day to current date")
        }
        return Calendar.current.compare(self, to: date, toGranularity: .day) == .orderedSame
    }
    
    static var yesterday: Date { return Date().dayBefore }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
}
