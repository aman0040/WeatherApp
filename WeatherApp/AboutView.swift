//
//  AboutView.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI

struct AboutView: View {
    @State private var tapCount = 0

    var body: some View {
        VStack(spacing: 20) {
            // App Name
            Text("Weather App")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
                .padding()

            // Created by
            Text("Created by Aman")
                .font(.title3)
                .foregroundColor(.white.opacity(0.8))
                .padding()

            // Icon with Tap Gesture
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
                .onTapGesture {
                    tapCount += 1
                    if tapCount == 3 {
                        // Show hidden feature (can customize this)
                        print("Secret feature unlocked!")
                    }
                }

            // App Description
            Text("This app provides live weather updates and forecasts for your favorite cities. Stay updated with accurate and reliable weather information at your fingertips.")
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding()

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
}
