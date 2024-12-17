//
//  NetworkService.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import Foundation
import CoreLocation
import Alamofire

protocol AddressLabelDelegate: AnyObject {
    func bind(_ address: String)
}

class APIRepository {
    weak var delegate: AddressLabelDelegate?
    
    private func requestData<T: Decodable>(url: URLComponents, parameters: [String: String], headers: [String: String], completion: @escaping (Result<T, AFError>) -> Void) {
        AF.request(url, method: .get, parameters: parameters, headers: HTTPHeaders(headers)).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    func fetchAddress(lat: String, lon: String) {
        guard let urlComponents = URLComponents(string: "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc") else { return }
        
        let parameters = [
            "coords": "\(lon),\(lat)",
            "orders": "roadaddr",
            "output": "json"
        ]
        
        let headers = [
            "x-ncp-apigw-api-key-id": APIKey.apiID,
            "x-ncp-apigw-api-key": APIKey.apiKey
        ]
        
        requestData(url: urlComponents, parameters: parameters, headers: headers) { [weak self] (result: Result<NaverResponse, AFError>) in
            switch result {
            case .success(let response):
                if response.results.isEmpty {
                    // TODO: geocoder name 값 활용
                } else {
                    guard let city = response.results[0].region.area1.alias else { return }
                    let result = response.results[0]
                    
                    let region = result.region.area2.name
                    let street = result.land.name
                    let number = result.land.number1
                    let building = result.land.addition0.value
                    
                    
                    self?.delegate?.bind("\(city) \(region) \(street) \(number) \(building)")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
