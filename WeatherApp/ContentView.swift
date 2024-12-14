//
//  ContentView.swift
//  WeatherApp
//
//  Created by Amandeep on 2024-12-13.
//

import SwiftUI


struct ContentView: View {
    @State private var selectedTab: Tab = .cityList
    @StateObject private var weatherViewModel = WeatherViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            CityListView()
                .environmentObject(weatherViewModel)
                .tabItem {
                    Label("Cities", systemImage: "list.dash")
                }
                .tag(Tab.cityList)

            SearchView()
                .environmentObject(weatherViewModel)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)

            SettingsView()
                .environmentObject(weatherViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(Tab.settings)
        }
           }

           enum Tab {
               case cityList
               case search
               case settings
           }
       }
