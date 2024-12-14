//
//  SettingsView.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    @State private var showAbout: Bool = false // State variable to control About page navigation
    @State private var isSettingInterval: Bool = false // State variable to control refresh interval sheet

    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Settings")
                    .font(.title2)
                    .bold()
                    .padding()
                    .foregroundColor(.white)

                // Buttons
                VStack(spacing: 20) {
                    // Button for Refresh Interval
                    Button(action: {
                        isSettingInterval = true // Show the refresh interval settings
                    }) {
                        Text("Refresh Interval")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .sheet(isPresented: $isSettingInterval) {
                        RefreshIntervalView() // Show the refresh interval settings page
                            .environmentObject(weatherViewModel)
                    }

                    // Button for About Page
                    Button(action: {
                        showAbout = true // Navigate to the About page
                    }) {
                        Text("About")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .sheet(isPresented: $showAbout) {
                        AboutView() // Show the About page
                    }
                }
                .padding()

                Spacer()
            }
            .background(Color.blue.opacity(0.5).edgesIgnoringSafeArea(.all)) // Background color
        }
    }
}

struct RefreshIntervalView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel

    var body: some View {
        VStack {
            Text("Set Refresh Interval")
                .font(.title2)
                .bold()
                .padding()

            Stepper(
                value: $weatherViewModel.refreshInterval,
                in: 1...60,
                step: 1
            ) {
                Text("Refresh Interval: \(Int(weatherViewModel.refreshInterval)) seconds")
                    .font(.headline)
            }
            .padding()

            Spacer()
        }
        .background(Color.blue.opacity(0.5).edgesIgnoringSafeArea(.all)) // Background color
    }
}
