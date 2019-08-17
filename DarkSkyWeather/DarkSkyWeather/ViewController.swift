//
//  ViewController.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/17/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /// Represents current timezone.
    @IBOutlet var timezoneLabel: UILabel!
    
    /// Represents summary for weather
    @IBOutlet var summaryLabel: UILabel!
    
    /// Represents current temperature for timezone.
    @IBOutlet var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

