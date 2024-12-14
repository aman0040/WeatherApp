//
//  CityListView.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI

struct CityListView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel

    var body: some View {
        NavigationView {
            VStack {
                // Header with title
                HStack {
                    Text("Algonquin Weather")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.leading)

                    Spacer()
                }
                .padding(.vertical)

                // City list
                List {
                    ForEach(weatherViewModel.cities) { city in
                        ZStack(alignment: .topTrailing) {
                            // NavigationLink for navigating to city detail view
                            NavigationLink(destination: CityDetailView(city: city)) {
                                EmptyView() // Transparent clickable area for navigation
                            }
                            .buttonStyle(PlainButtonStyle()) // Prevents any visual changes on click

                            // City row content
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(Int(city.temperature))°C")
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(.white)
                                    Text(city.name)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(city.localTime)
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.7))
                                    Text(city.weatherDescription.capitalized)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                Spacer()
                                Image(systemName: city.weatherIcon)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.yellow)
                            }
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: city.gradientColors),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(10)
                            .shadow(radius: 5)

                            // Small garbage icon for deleting the city
                            Button(action: {
                                if let index = weatherViewModel.cities.firstIndex(where: { $0.id == city.id }) {
                                    weatherViewModel.cities.remove(at: index)
                                }
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.white)
                                    .padding(8)
                            }
                            .buttonStyle(BorderlessButtonStyle()) // Ensures the button works properly
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.blue.opacity(0.5).edgesIgnoringSafeArea(.all))
            }
        }
        .background(Color.blue.opacity(0.5).edgesIgnoringSafeArea(.all))
    }
}
