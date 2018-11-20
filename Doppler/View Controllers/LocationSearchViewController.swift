//
//  LocationSearchViewController.swift
//  Doppler
//
//  Created by Ryan Brashear on 11/15/18.
//  Copyright © 2018 Ryan Brashear. All rights reserved.
//

import UIKit

class LocationSearchViewController: UIViewController,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    let apiManger = APIManager()
    var geocodingData: GeocodingData?
    var weatherData: WeatherData?
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    func  handleError() {
        geocodingData = nil
        weatherData = nil
    }
    func retreiveGeocodingData(searchAddress: String){
        apiManger.geocode(address: searchAddress){
            (geocodingData, error) in
            if let receivedError = error {
                print(receivedError.localizedDescription)
                self.handleError()
                return
            }
            if let receivedData = geocodingData {
                self.geocodingData = receivedData
                self.retrieveWeatherData(latitude: receivedData.latitude, longitude: receivedData.longitude)
            } else {
                self.handleError()
                return
            }
        }
    }
    func retrieveWeatherData(latitude: Double,longitude: Double){
        apiManger.getWeather(at: (latitude, longitude)){(weatherData,error) in
            if let receiedError = error {
                print(receiedError.localizedDescription)
                self.handleError()
                return
            }
            if let receiedData = weatherData {
                self.weatherData = receiedData
                self.performSegue(withIdentifier: "unwindToWeatherDisplay", sender: self)
            } else {
                self.handleError()
                return
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchAddress = searchBar.text?.replacingOccurrences(of: " ", with: "+") else{
            return
        }
        retreiveGeocodingData(searchAddress: searchAddress)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? WeatherDisplayViewController,
        let retrievedGeocodingData = geocodingData,
            let retrievedWeatherData = weatherData {
            destinationVC.displayWeatherData = retrievedWeatherData
            destinationVC.displayGeocodingData = retrievedGeocodingData
        }
    }
}
