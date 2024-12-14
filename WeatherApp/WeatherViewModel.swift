//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI
import Combine
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var refreshInterval: Double = 10.0 // Default refresh interval in seconds
    private let defaultCities = ["Tehran", "Dubai", "London", "New York", "Tokyo"] // Default cities
    private let apiKey = "d7434421eb11491de092acbf839c6663" // Replace with your API key
    private var timer: AnyCancellable? // Timer to manage periodic updates

    init() {
        fetchWeather(for: defaultCities) // Load default cities on initialization
        startTimer() // Start timer for periodic weather updates
    }

    // Fetch weather data for a list of cities
    func fetchWeather(for cityNames: [String]) {
        for cityName in cityNames {
            let encodedCity = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? cityName
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&units=metric&appid=\(apiKey)") else { continue }

            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }

                do {
                    let weatherResponse = try JSONDecoder().decode(OpenWeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        let city = City(
                            name: weatherResponse.name,
                            temperature: weatherResponse.main.temp,
                            localTime: self.getLocalTime(for: weatherResponse.timezone),
                            weatherDescription: weatherResponse.weather.first?.description ?? "",
                            weatherIcon: self.getWeatherIcon(for: weatherResponse.weather.first?.icon ?? ""),
                            uvIndex: 0, // Placeholder
                            windSpeed: weatherResponse.wind.speed,
                            humidity: weatherResponse.main.humidity,
                            coordinate: CLLocationCoordinate2D(latitude: weatherResponse.coord.lat, longitude: weatherResponse.coord.lon),
                            forecast: []
                        )
                        if !self.cities.contains(where: { $0.name == city.name }) {
                            self.cities.append(city)
                        }
                    }
                } catch {
                    print("Error decoding weather data: \(error)")
                }
            }.resume()
        }
    }

    // Add a city to the list
    func addCity(_ city: City) {
        if !cities.contains(where: { $0.name == city.name }) {
            cities.append(city)
        }
    }

    // Remove city from the list
    func removeCity(at offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
    }

    // Start the timer to refresh weather data at the specified interval
    func startTimer() {
        timer?.cancel() // Cancel any existing timer
        timer = Timer.publish(every: refreshInterval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                let cityNames = self.cities.map { $0.name }
                self.fetchWeather(for: cityNames) // Refresh weather data periodically
            }
    }

    // Get local time for the specified timezone offset
    private func getLocalTime(for timezone: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(Date().timeIntervalSince1970 + Double(timezone)))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    // Map OpenWeather icon codes to SF Symbols
    private func getWeatherIcon(for iconCode: String) -> String {
        switch iconCode {
        case "01d", "01n": return "sun.max"
        case "02d", "02n": return "cloud.sun"
        case "03d", "03n": return "cloud"
        case "04d", "04n": return "smoke"
        case "09d", "09n": return "cloud.rain"
        case "10d", "10n": return "cloud.sun.rain"
        case "11d", "11n": return "cloud.bolt"
        case "13d", "13n": return "snow"
        case "50d", "50n": return "cloud.fog"
        default: return "questionmark.circle"
        }
    }
}
