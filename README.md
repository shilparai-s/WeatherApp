## Weather App Project README

## SwiftWeather: Modern Concurrency Weather App

This repository contains a weather application that leverages Swift's modern concurrency features to provide real-time weather information for the user's current location.

### Features

- Current weather conditions 
- Location-based weather using CoreLocation with async/await - Continuation

### App Architecture

- **MVVM Architecture:** Clean separation of UI, business logic, and data
- **Actors:** Used for thread-safe location and weather data management
- **SwiftUI:** Modern declarative UI with efficient view updates
- **Task and TaskGroup:** For managing concurrent operations
