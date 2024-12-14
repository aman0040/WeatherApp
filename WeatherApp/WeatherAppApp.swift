//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var weatherViewModel = WeatherViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherViewModel)
        }
    }
}
