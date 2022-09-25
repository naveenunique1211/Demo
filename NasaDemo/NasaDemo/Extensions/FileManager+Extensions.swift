//
//  FileManager+Extensions.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation

extension FileManager {
    static var documentDirectoryUrl: URL {
        guard let documentsDirectoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            fatalError("Unable to locate or create the documents directory")
        }
        return documentsDirectoryUrl
    }
    
    static var applicationSupportDirectoryUrl: URL {
        guard let applicationSupportDirectoryUrl = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            fatalError("Unable to locate or create the application support directory")
        }
        return applicationSupportDirectoryUrl
    }
}
