//
//  LocationManager.swift
//  Weatha
//
//  Created by Christopher Koski on 3/28/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  let manager = CLLocationManager()
  
  @Published var locationStatus: CLAuthorizationStatus?
  @Published var lastLocation: CLLocationCoordinate2D?
  @Published var isLoading = false
  
  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }
  
  func requestLocation() {
    isLoading = true
    manager.requestWhenInUseAuthorization()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    lastLocation = locations.last?.coordinate
    isLoading = false
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error getting location", error)
    isLoading = false
  }
}
