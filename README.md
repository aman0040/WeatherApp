# Weather App 🌤️

A beautiful and feature-rich weather app built using SwiftUI, allowing users to view weather details for different cities. The app displays current temperature, wind speed, humidity, UV index, and hourly forecasts, along with an interactive map.

## Features

- **Current Weather Details**: Temperature, wind speed, humidity, UV index.
- **Interactive Map**: Displays the selected city's location on a map.
- **Hourly Forecasts**: Scrollable view showing hourly weather updates.
- **Gradient UI**: Dynamic gradient background based on weather conditions.
- **Responsive Design**: Works well across all iOS devices.

## API Key Management

This app uses the OpenWeatherMap API to fetch weather data. Replace the placeholder API key in `WeatherViewModel` with your own API key.

1. Sign up for an API key from [OpenWeatherMap](https://openweathermap.org/).
2. Replace the `apiKey` variable in `WeatherViewModel.swift` with your API key:
   ```swift
   private let apiKey = "YOUR_API_KEY_HERE"
