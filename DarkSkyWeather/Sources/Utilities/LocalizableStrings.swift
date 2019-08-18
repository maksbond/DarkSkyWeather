//
//  LocalizableStrings.swift
//  DarkSkyWeather
//
//  Created by Maksym Bondar on 8/18/19.
//  Copyright © 2019 Maksym Bondar. All rights reserved.
//

import Foundation

/// Localizable strings for application.
struct LocalizableStrings {
    // MARK: Error titles and messages
    static let errorTitle = NSLocalizedString("Error", comment: "Title for error alert")
    static let cellularTurnOffTitle = NSLocalizedString("Cellural Data is Turned Off", comment: "Title for error alert")
    static let unknownErrorMessage = NSLocalizedString("Unknown error", comment: "Message for unknown error")
    static let wrongUrlErrorMessage = NSLocalizedString("URL to https://darksky.net/ can't be created.", comment: "Message for wrong URL")
    static let requestErrorMessage = NSLocalizedString("Request to https://darksky.net/ is failed.", comment: "Message for failed request")
    static let noInternetConnectionErrorMessage = NSLocalizedString("Turn on cellural data or use Wi-Fi to access data.", comment: "Message for no internet connection.")
    
    // MARK: Button titles
    static let okButton = NSLocalizedString("OK", comment: "OK button")
    static let settingsButton = NSLocalizedString("Settings", comment: "OK button")
}
