//
//  LocationManager.swift
//  itsWeather
//
//  Created by Christopher Koski on 4/30/22.
//

import Foundation
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  let manager = CLLocationManager()
  
  @Published var location: CLLocationCoordinate2D?
  
  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    
    //Need this to start getting location!!!
    manager.startUpdatingLocation()
  }
  
  func requestLocation() {
    manager.requestLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    location = locations.first?.coordinate
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
}
