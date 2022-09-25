//
//  APIError.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation

enum APIError: LocalizedError {
    case incorrectParameters
    case requestError
    case invalidResponse
    case responseUnsuccessful
    case invalidData
    case jsonParsingError
    
    var errorDescription: String {
        switch self {
        case .incorrectParameters: return "Incorrect parameters for request"
        case .requestError: return "Request error"
        case .invalidResponse: return "Invalid response"
        case .responseUnsuccessful: return "Response unsuccessful"
        case .invalidData: return "Invalid data"
        case .jsonParsingError: return "JSON parsing error"
        }
    }
}
