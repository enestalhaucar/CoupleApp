//
//  LocationManager.swift
//  CoupleApp
//
//  Created by Enes Talha Uçar  on 28.09.2024.
//

import CoreLocation
import Combine

class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userLocation : CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.userLocation = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func calculateDistance(from location1: CLLocation, to location2: CLLocation) -> Double {
        return location1.distance(from: location2)
    }
}
