//
//  WeatherService.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/17/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherServiceErrorCode: Int, CustomStringConvertible {
    case unknown = -1
    case wrongUrl
    case requestError
    
    var description: String {
        switch self {
        case .unknown:
            return "Unknown error for weather service."
        case .wrongUrl:
            return "Failed to generate url for latitude and longitude."
        case .requestError:
            return "Request failed."
        }
    }
}

class WeatherService {
    
    ///
    static let errorDomain = "weatherservice.domain"
    
    ///
    
    typealias WeatherCompletion = (Weather?, NSError?) -> ()
    ///
    private let queue: DispatchQueue
    
    init(queue: DispatchQueue) {
        self.queue = queue
    }
    
    func requestCurrent(for coordinates: (latitude: Double, longitude: Double), completion: @escaping WeatherCompletion) {
        guard let url = URL(string: "\(APIKeys.request)/\(APIKeys.privateKey)/\(coordinates.latitude),\(coordinates.longitude)?units=si") else {
            completion(nil, NSError(domain: WeatherService.errorDomain, code: WeatherServiceErrorCode.wrongUrl.rawValue, userInfo: [NSLocalizedDescriptionKey: WeatherServiceErrorCode.wrongUrl.description]))
            return
        }
        request(url).validate(statusCode: 200..<300).responseJSON(queue: self.queue, options: []) { response in
            if let error = response.error {
                completion(nil, NSError(domain: WeatherService.errorDomain, code: WeatherServiceErrorCode.requestError.rawValue, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]))
            } else if let json = response.result.value as? [String: Any] {
                completion(Weather(json), nil)
            }
        }
    }
}
