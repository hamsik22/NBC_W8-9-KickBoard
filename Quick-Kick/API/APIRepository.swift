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
    func fetchAddress(lat: String, lon: String)
}

class APIRepository: APIRepositoryProtocol {
    private func requestData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    func fetchAddress(lat: String, lon: String) {
        guard let urlComponents = URLComponents(string: "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc") else {
            return
        }
        
        let parameters = [
                    "coords": "\(lon),\(lat)",
                    "orders": "roadaddr",
                    "output": "json"
                ]
        
        let headers: HTTPHeaders = HTTPHeaders([
            "x-ncp-apigw-api-key-id": APIKey.apiID,
            "x-ncp-apigw-api-key": APIKey.apiKey
        ])
        
        
        AF.request(urlComponents, method: .get, parameters: parameters, headers: headers)
            .responseDecodable(of: NaverResponse.self) { response in
                switch response.result {
                case .success(let response):
                    //print(response)
                    
                    if !response.results.isEmpty {
                        print(response.results[0].region.area1.alias)
                        print(response.results[0].region.area2.name)
                        print(response.results[0].land.name)
                        print(response.results[0].land.number1)
                        print(response.results[0].land.addition0.value)
                        if response.results[0].land.addition0.value == "" {
                            print("empty")
                        }
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
