//
//  GeocodingData.swift
//  Doppler
//
//  Created by Jacob Tassinari on 11/19/18.
//  Copyright © 2018 Ryan Brashear. All rights reserved.
//

import Foundation
import SwiftyJSON
class GeocodingData {
    enum GeocodingDataKeys: String {
        case results = "results"
        case formatttedAddress = "formatted_address"
        case geometry = "geometry"
        case location = "location"
        case latitude = "lat"
        case longitude = "lng"
    }
    var formattedAddress: String
    var latitude: Double
    var longitude: Double
    
    init(formattedAddress:String,latitude:Double,longitude:Double){
        self.formattedAddress = formattedAddress
        self.latitude = latitude
        self.longitude = longitude
    }
    
    convenience init?(json: JSON){
        guard let results = json[GeocodingDataKeys.results.rawValue].array, results.count > 0 else {
            return nil
        }
        guard let formattedAddress = results[0][GeocodingDataKeys.formatttedAddress.rawValue].string else{
            return nil
        }
        guard let latitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.latitude.rawValue].double else {
            return nil
        }
        guard let longitude = results[0][GeocodingDataKeys.geometry.rawValue][GeocodingDataKeys.location.rawValue][GeocodingDataKeys.longitude.rawValue].double else {
            return nil
        }
        self.init(formattedAddress: formattedAddress, latitude: latitude, longitude: longitude)
    }
}
