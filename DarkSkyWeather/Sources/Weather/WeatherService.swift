//
//  WeatherService.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/17/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import Foundation
import Alamofire

/// Error coded for weather service.
enum WeatherServiceErrorCode: Int, CustomStringConvertible {
    case unknown = -1
    case wrongUrl
    case requestError
    case noIntertetConnection
    
    /// Implementation of CustomStringConvertible protocol.
    var description: String {
        switch self {
        case .unknown:
            return "Unknown error for weather service."
        case .wrongUrl:
            return "Failed to generate url for latitude and longitude."
        case .requestError:
            return "Request failed."
        case .noIntertetConnection:
            return "A network resource was requested, but an internet connection has not been established and can’t be established automatically."
        }
    }
}

/// Reprecents service to get weather from the WEB.
class WeatherService {
    
    /// Error Domain for weather service.
    static let errorDomain = "weatherservice.domain"
    
    /// Completions for weather request.
    typealias WeatherCompletion = (Weather?, NSError?) -> ()
    
    /// Queue which used for request.
    private let queue: DispatchQueue
    
    /// Default initializer.
    init(queue: DispatchQueue) {
        self.queue = queue
    }
    
    /// Request weather for latitude and longitude.
    func requestWeather(for coordinates: (latitude: Double, longitude: Double), completion: @escaping WeatherCompletion) {
        guard let url = WeatherAPI.formatRequest(for: coordinates, lang: "uk") else {
            completion(nil, NSError(domain: WeatherService.errorDomain, code: WeatherServiceErrorCode.wrongUrl.rawValue, userInfo: [NSLocalizedDescriptionKey: WeatherServiceErrorCode.wrongUrl.description]))
            return
        }
        request(url).validate(statusCode: 200..<300).responseJSON(queue: self.queue, options: []) { response in
            if let error = response.error {
                var description = error.localizedDescription
                var code = WeatherServiceErrorCode.requestError.rawValue
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    code = WeatherServiceErrorCode.noIntertetConnection.rawValue
                    description = WeatherServiceErrorCode.noIntertetConnection.description
                }
                completion(nil, NSError(domain: WeatherService.errorDomain, code: code, userInfo: [NSLocalizedDescriptionKey: description]))
            } else if let json = response.result.value as? [String: Any] {
                completion(Weather(json), nil)
            }
        }
    }
}
