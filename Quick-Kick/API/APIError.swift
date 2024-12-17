//
//  APIError.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import Foundation

enum APIError: Error {
    
}

enum APIKey {
    static var apiID: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY_ID") as? String else {
            fatalError("API_KEY_ID not found in Info.plist")
        }
        return key
    }
    
    static var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return key
    }
}
