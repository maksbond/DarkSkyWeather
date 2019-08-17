//
//  ViewController.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/17/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    /// Represents current timezone.
    @IBOutlet var timezoneLabel: UILabel!
    
    /// Represents summary for weather
    @IBOutlet var summaryLabel: UILabel!
    
    /// Represents current temperature for timezone.
    @IBOutlet var temperatureLabel: UILabel!
    
    /// Location manager to get current location.
    private let locationManager = CLLocationManager()
    
    private let weatherService = WeatherService(queue: DispatchQueue.global(qos: .userInitiated))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard CLLocationManager.authorizationStatus() == .authorizedWhenInUse else {
            // TODO: Add handler for failed status
            return
        }
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherService.requestCurrent(for: (latitude: latitude, longitude: longitude)) { weather, error in
                if let error = error {
                    // TODO: Process error
                } else if let weather = weather {
                    DispatchQueue.main.async { [weak self] in
                        guard let strongSelf = self else { return }
                        
                        if let summary = weather.summary, let icon = weather.icon, let timezone = weather.timezone, let temperature = weather.temperature {
                            strongSelf.summaryLabel.text = summary
                            strongSelf.timezoneLabel.text = timezone
                            strongSelf.temperatureLabel.text = "\(round(temperature))"
                        }
                    }
                }
            }
        }
    }


}

