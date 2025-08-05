//
//  LocationService.swift
//  WeatherApp
//
//  Created by Shilpa S on 05.08.25.
//

import Foundation
import CoreLocation

class LocationService: NSObject, AsyncLocationService, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    private var location: CLLocation? = nil
    private var callback: LOCATION_CALLBACK? = nil
    
    override init() {
        super.init()
    }
    
    deinit {
        self.locationManager.stopUpdatingLocation()
    }
    
    var hasLocationPermission: Bool {
        guard locationManager.authorizationStatus == .authorizedWhenInUse else {
            return false
        }
        return true
    }
    
    func requestLocations(onCompletion callback: @escaping (Coordinates?, Error?) -> ()) {
        self.locationManager.delegate = self
        self.callback = callback
        
        if hasLocationPermission {
            self.locationManager.startUpdatingLocation()
        }else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }

    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if self.locationManager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
            DispatchQueue.main.async {
                let coordinates = Coordinates(latitude: self.location?.coordinate.latitude ?? 0.0, longitude: self.location?.coordinate.longitude ?? 0.0)
                self.callback?(coordinates, nil)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.location = nil
        self.locationManager.stopUpdatingLocation()
        DispatchQueue.main.async {
            self.callback?(nil, error)
        }
    }

}
