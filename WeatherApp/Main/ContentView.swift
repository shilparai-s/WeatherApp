//
//  ContentView.swift
//  WeatherApp
//
//  Created by Shilpa S on 04.08.25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var viewModel = WeatherFetchViewModel(weatherService: WeatherService(), locationService: LocationService())
    
    var body: some View {
        ScrollView {
            VStack(spacing:15) {
                Text("My Location")
                    .font(.subheadline)
                Text(viewModel.city)
                    .font(.largeTitle)
                Text(viewModel.temparature )
                    .font(.title2)
                Text(viewModel.condition)
                    .font(.title3)                
            }
        }
        .onAppear() {
            Task {
                await self.viewModel.getMyLocationWeather()
            }
        }
    }
    
}

#Preview {
    ContentView()
}
