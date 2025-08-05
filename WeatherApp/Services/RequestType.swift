//
//  RequestType.swift
//  WeatherApp
//
//  Created by Shilpa S on 05.08.25.
//

import Foundation

public enum WeatherRequestType {
    case latlong
    case city
    case postalCode
}

public protocol WeatherRequestService {
    func getWeather(type: WeatherRequestType, parameters: [String]) async throws -> Weather
}
