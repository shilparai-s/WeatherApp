//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Shilpa S on 04.08.25.
//

import SwiftUI

struct WeatherService : WeatherRequestService {
    private let apiKey = "d6d1b228d07643d7bc2205956250408"
    private let baseURL = "https://api.weatherapi.com/v1/current.json"
    
    func getWeather(type: WeatherRequestType, parameters: [String]) async throws -> Weather {
        
        guard var urlComponent = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        let paramString = parameters.joined(separator: ",")
        urlComponent.queryItems = [URLQueryItem(name: "q", value: paramString),
                                   URLQueryItem(name: "KEY", value: apiKey)]
        guard let requestUrl = urlComponent.url else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: requestUrl)
        print(String(data: data, encoding: .utf8) ?? "Unable to print data")
        return try JSONDecoder().decode(Weather.self, from: data)
    }
}
