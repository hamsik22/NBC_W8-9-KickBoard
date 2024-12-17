//
//  NaverResponse.swift
//  Quick-Kick
//
//  Created by EMILY on 17/12/2024.
//

import Foundation

struct NaverResponse: Decodable {
    let status: Status
    let results: [Address]
    
    struct Status: Decodable {
        let code: Int           // 0
        let name: String        // ok
    }
    
    struct Address: Decodable {
        let region: Region
        let land: Land
        
        struct Region: Decodable {
            let area1: Area
            let area2: Area
            
            struct Area: Decodable {
                let name: String        // 서울특별시, 강남구
                let alias: String?      // 서울, nil
            }
        }
        
        struct Land: Decodable {
            let number1: String         // 396
            let addition0: Building
            let name: String            // 강남대로
            
            struct Building: Decodable {
                let type: String        // building
                let value: String       // 강남역
            }
        }
    }
}
