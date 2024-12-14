//
//  City.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI
import CoreLocation


struct Forecast: Identifiable {
    var id = UUID()
    var hour: String
    var temperature: Double
    var weatherIcon: String
}

struct City: Identifiable {
    let id = UUID()
    let name: String
    let temperature: Double
    let localTime: String
    let weatherDescription: String
    let weatherIcon: String
    let uvIndex: Int
    let windSpeed: Double
    let humidity: Int
    let coordinate: CLLocationCoordinate2D
    var forecast: [Forecast]


    // Gradient Colors based on temperature
    var gradientColors: [Color] {
        if temperature < 10 {
            return [Color.blue, Color.cyan]
        } else if temperature < 25 {
            return [Color.green, Color.blue]
        } else {
            return [Color.orange, Color.red]
        }
    }
}
