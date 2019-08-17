//
//  ViewController.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/17/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    /// Represents current timezone.
    @IBOutlet var timezoneLabel: UILabel!
    
    /// Represents summary for weather
    @IBOutlet var summaryLabel: UILabel!
    
    /// Represents current temperature for timezone.
    @IBOutlet var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "\(APIKeys.request)/\(APIKeys.privateKey)/42.3601,-71.0589") else {
            return
        }
        request(url).responseJSON { response in
            if let error = response.error {
                print(error)
            } else if let json =  response.result.value {
                print(json)
            }
        }
    }


}

