//
//  SearchView.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI
import CoreLocation


struct SearchView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @State private var searchText: String = ""
    @State private var results: [City] = []
    let popularCities = ["Tehran", "New York", "Dubai", "London", "Hong Kong", "Beijing", "Delhi", "Chennai", "Istanbul", "Singapore", "Rome"]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Search Field
                TextField("Search for a city...", text: $searchText, onCommit: searchCities)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .shadow(radius: 3)

                // Popular Cities Section
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(popularCities, id: \.self) { city in
                            Button(action: {
                                addCityByName(city)
                            }) {
                                Text(city)
                                    .padding()
                                    .background(Color.white.opacity(0.9))
                                    .foregroundColor(.blue)
                                    .cornerRadius(20)
                                    .shadow(radius: 3)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Search Results
                List {
                    ForEach(results) { city in
                        HStack {
                            Text(city.name)
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                weatherViewModel.addCity(city)
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                    .font(.title2)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.cyan.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )
            .navigationTitle("Search for City")
        }
    }

    private func searchCities() {
        // Simulate search results
        results = [
            City(name: searchText, temperature: 22.0, localTime: "12:00 PM", weatherDescription: "Sunny", weatherIcon: "sun.max", uvIndex: 0, windSpeed: 5.0, humidity: 40, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), forecast: [])
        ]
    }

    private func addCityByName(_ cityName: String) {
        let city = City(name: cityName, temperature: 25.0, localTime: "3:00 PM", weatherDescription: "Sunny", weatherIcon: "sun.max", uvIndex: 1, windSpeed: 3.0, humidity: 60, coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0), forecast: [])
        weatherViewModel.addCity(city)
    }
}
