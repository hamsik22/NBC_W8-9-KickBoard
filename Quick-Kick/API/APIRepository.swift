//
//  NetworkService.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import Foundation
import CoreLocation
import Alamofire

protocol APIRepositoryProtocol {
    
}

class APIRepository: APIRepositoryProtocol {
    private func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    func fetchAddress(from coordinate: CLLocationCoordinate2D, completion: @escaping (Result<String, APIError>) -> Void) {
        let lat = coordinate.latitude.description
        let lon = coordinate.longitude.description
        
        let urlCompoments = URLComponents(string: "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2")
    }
}
