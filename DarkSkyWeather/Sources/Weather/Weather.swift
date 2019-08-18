//
//  Weather.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/17/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import Foundation

/// Keys to access current weather.
private struct WeatherKeys {
    static let timezone = "timezone"
    static let currentWeather = "currently"
    static let summary = "summary"
    static let icon = "icon"
    static let temperature = "temperature"
}

struct Weather {
    
    /// Current timezone according to attitude and longiture.
    let timezone: String?
    
    /// Current summary.
    let summary: String?
    
    /// Current weather icon.
    let icon: String?
    
    /// Current temperature.
    let temperature: Double?
    
    ///
    init(_ json: [String: Any]) {
        self.timezone = json[WeatherKeys.timezone] as? String
        guard let currentWeather = json[WeatherKeys.currentWeather] as? [String: Any] else {
            self.summary = nil
            self.icon = nil
            self.temperature = nil
            return
        }
        self.summary = currentWeather[WeatherKeys.summary] as? String
        self.icon = currentWeather[WeatherKeys.icon] as? String
        self.temperature = currentWeather[WeatherKeys.temperature] as? Double
    }
}
