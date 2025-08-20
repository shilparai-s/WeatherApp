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
    private var locationContinuation : CheckedContinuation<Coordinates?, any Error>?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
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
    
    @MainActor
    func getCurrentLocation() async throws -> Coordinates? {
        
        try await withCheckedThrowingContinuation({continuation in
            locationContinuation = continuation
            if hasLocationPermission {
                self.locationManager.startUpdatingLocation()
            }else {
                self.locationManager.requestLocation()
            }
        })
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if self.locationManager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location found")
        if let location = locations.first {
            self.location = location
            let coordinates = Coordinates(latitude: self.location?.coordinate.latitude ?? 0.0, longitude: self.location?.coordinate.longitude ?? 0.0)
            self.locationContinuation?.resume(returning: coordinates)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location not found")

        self.location = nil
        self.locationManager.stopUpdatingLocation()
        self.locationContinuation?.resume(throwing: error)
    }

}
