//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Shilpa S on 05.08.25.
//

import Foundation

public struct Weather : Codable {
    let location : Location
    let current: Current
}

struct Location : Codable{
    let name: String
    let region: String
    let country: String
}

struct Current : Codable{
    let condition : Condition
    let temp_c : CGFloat
    let temp_f : CGFloat
    let is_day : Int
    let humidity: Int
    let cloud: Int
    let feelslike_c: CGFloat
    let feelslike_f: CGFloat

}

struct ForeCast: Codable {
    
}

struct Condition : Codable {
    let text: String
    let icon: String
    let code: Int
}

