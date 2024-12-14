//
//  CityDetailView.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//
import SwiftUI
import MapKit

struct CityDetailView: View {
    var city: City
    @State private var region: MKCoordinateRegion

    init(city: City) {
        self.city = city
        _region = State(initialValue: MKCoordinateRegion(
            center: city.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        ))
    }

    var body: some View {
        VStack(spacing: 20) {
            // Spacer for Top Padding
            Spacer()
                .frame(height: 60)

            // City Card
            VStack {
                Text(city.name) // City Name
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)

                Text("\(Int(city.temperature))°C") // Temperature
                    .font(.system(size: 50, weight: .bold))
                    .foregroundColor(.white)

                Text(city.localTime) // Local Time
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))

                Text(city.weatherDescription.capitalized) // Weather Description
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: city.gradientColors),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            )
            .padding(.horizontal)

            // Map Section
            Map(coordinateRegion: $region)
                .frame(height: 300)
                .cornerRadius(15)
                .padding(.horizontal)

            // Weather Stats Section
            VStack(spacing: 20) {
                HStack(spacing: 15) {
                    WeatherStatView(icon: "sun.max", value: "\(city.uvIndex)", title: "UV Index")
                    WeatherStatView(icon: "wind", value: String(format: "%.1f m/s", city.windSpeed), title: "Wind")
                    WeatherStatView(icon: "humidity.fill", value: "\(city.humidity)%", title: "Humidity")
                }
                .padding(.vertical, 10)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.15))
            )
            .padding(.horizontal)

            Spacer() // Ensure content stays well-aligned
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: city.gradientColors),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .edgesIgnoringSafeArea(.all)
    }
}

// Reusable Weather Stats Component
struct WeatherStatView: View {
    var icon: String
    var value: String
    var title: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.white)

            Text(value)
                .font(.headline)
                .foregroundColor(.white)

            Text(title)
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.2))
        )
    }
}
