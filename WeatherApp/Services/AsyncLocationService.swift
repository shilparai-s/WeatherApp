//
//  AsyncLocationService.swift
//  WeatherApp
//
//  Created by Shilpa S on 05.08.25.
//

import Foundation
import CoreLocation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

protocol AsyncLocationService {
    typealias LOCATION_CALLBACK = ((Coordinates?, Error?) -> ())
    func requestLocations(onCompletion: @escaping LOCATION_CALLBACK)
}
