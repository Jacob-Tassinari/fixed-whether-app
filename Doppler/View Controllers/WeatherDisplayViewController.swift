//
//  WeatherDisplayViewController.swift
//  Doppler
//
//  Created by Ryan Brashear on 11/15/18.
//  Copyright © 2018 Ryan Brashear. All rights reserved.
//

import UIKit

class WeatherDisplayViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var highTemperatureLabel: UILabel!
    @IBOutlet weak var lowTemperatureLabel: UILabel!
    
    var displayWeatherData: WeatherData! {
        didSet {
            iconLabel.text = displayWeatherData.condition.icon
            currentTemperatureLabel.text = "\(displayWeatherData.temperature)º"
            highTemperatureLabel.text = "\(displayWeatherData.highTemperature)º"
            lowTemperatureLabel.text = "\(displayWeatherData.lowTemperature)º"
        }
    }
    var displayGeocodingData: GeocodingData! {
        didSet {
            locationLabel.text = displayGeocodingData.formattedAddress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupDefaultUI()
    }
    func setupDefaultUI(){
        locationLabel.text = ""
        iconLabel.text = "😀"
        currentTemperatureLabel.text = "Enter Location"
        highTemperatureLabel.text = "_"
        lowTemperatureLabel.text = "_"
    }
    @IBAction func unwindToWeatherDisplay(segue:UIStoryboardSegue) {}
}

