//
//  WeatherFetchViewModel.swift
//  WeatherApp
//
//  Created by Shilpa S on 05.08.25.
//

import SwiftUI
import Combine

@MainActor
class WeatherFetchViewModel: ObservableObject {
    @Published var weather : Weather? = nil
    @Published var city: String = ""
    @Published var Country: String = ""
    @Published var condition: String = ""
    @Published var temparature: String = ""
    
    private let weatherService :  WeatherRequestService
    private let locationService : AsyncLocationService
    
    init(weatherService: WeatherRequestService, locationService: AsyncLocationService) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    
    private func getFormattedTempratue() -> String {
        if let temp = self.weather?.current.temp_c {
            let tempMesaure = Measurement(value: temp, unit: UnitTemperature.celsius)
            return tempMesaure.formatted()
        }
        return ""
    }

    func getMyLocationWeather() async {
        do {
            
            if let location = try await self.locationService.getCurrentLocation() {
                let weather = try await weatherService.getWeather(type: .latlong, parameters: [String(location.latitude), String(location.longitude)])
                //UI Updates to be done in main actor
                await MainActor.run(body: {
                    self.weather = weather
                    self.city = self.weather?.location.name ?? "--"
                    self.Country = self.weather?.location.country ?? "--"
                    self.condition = self.weather?.current.condition.text ?? "--"
                    self.temparature = self.getFormattedTempratue()
                })
            }
            
        }catch {
            print(error)
        }
    }
    
}
