//
//  ViewController+UI.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/18/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import UIKit
import Foundation
import os.log

extension ViewController {
    /// Show alert based on error codes.
    func showAlert(for error: WeatherServiceErrorCode) {
        DispatchQueue.main.async {
            var message: String?
            var title = LocalizableStrings.errorTitle
            var actions = [UIAlertAction(title: LocalizableStrings.okButton, style: .default, handler: nil)]
            switch error {
            case .unknown:
                message = LocalizableStrings.unknownErrorMessage
            case .wrongUrl:
                message = LocalizableStrings.wrongUrlErrorMessage
            case .requestError:
                message = LocalizableStrings.requestErrorMessage
            case .noIntertetConnection:
                actions.insert(UIAlertAction(title: LocalizableStrings.settingsButton, style: .default, handler: { _ in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { success in
                            os_log(.info, "Settings opened: %{public}@", String(success))
                        })
                    }
                }), at: 0)
                title = LocalizableStrings.cellularTurnOffTitle
                message = LocalizableStrings.noInternetConnectionErrorMessage
            }
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            actions.forEach { alertAction in
                alert.addAction(alertAction)
            }
            self.present(alert, animated: true, completion: nil)
        }
    }
}
