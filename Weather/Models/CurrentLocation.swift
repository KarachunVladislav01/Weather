//
//  CurrentLocation.swift
//  weatherApp
//
//  Created by Vladislav on 4/18/18.
//  Copyright © 2018 Vladislav. All rights reserved.
//

import Foundation
import CoreLocation

let locationManger = CLLocationManager()

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
        if let lat = (locations.last?.coordinate.latitude),let long  = (locations.last?.coordinate.longitude) {
            print("\(long),\(lat)")
            weatherFromInternet(longitude: "\(long)", latitude: "\(lat)")
        } else {
            print("No coordinates")
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
