//
//  AddressRepository.swift
//  Quick-Kick
//
//  Created by EMILY on 16/12/2024.
//

import Foundation
import CoreLocation
import Alamofire

// delegate : AddKickboard > NoticeView
protocol AddressLabelDelegate: AnyObject {
    func bind(_ address: String)
}

class AddressRepository {
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
                // 네이버 api result 값이 비어있을 경우 corelocation geocoder에서 받은 주소값으로 대체 바인딩
                if response.results.isEmpty {
                    self?.getAddress(lat: lat, lon: lon, completion: { address in
                        DispatchQueue.main.async {
                            self?.delegate?.bind(address)
                        }
                    })
                    
                } else {
                    // 네이버 api response 값들을 조합하여 도로명주소 + 건물명을 주소 label과 바인딩
                    guard let city = response.results[0].region.area1.alias else { return }
                    let result = response.results[0]
                    
                    let region = result.region.area2.name
                    let street = result.land.name
                    let number = result.land.number1
                    let building = result.land.addition0.value
                    
                    DispatchQueue.main.async {
                        self?.delegate?.bind("\(city) \(region) \(street) \(number) \(building)")
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAddress(lat: String, lon: String, completion: @escaping (String) -> Void) {
        let lat: CLLocationDegrees = CLLocationDegrees(lat) ?? 0
        let lon: CLLocationDegrees = CLLocationDegrees(lon) ?? 0
        let location = CLLocation(latitude: lat, longitude: lon)
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard
                let placemark = placemarks?[0],
                let city = placemark.administrativeArea,
                let region = placemark.subLocality,
                let number = placemark.subThoroughfare
            else { return }
            completion("\(city) \(region) \(number)")
        }
    }
}
