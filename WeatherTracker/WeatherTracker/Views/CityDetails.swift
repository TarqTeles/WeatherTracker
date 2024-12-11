//
//  CityDetails.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

struct CityDetails: View {
    let weather: WeatherViewModel
    
    private let lightGray = Color(red: 0.9, green: 0.9, blue: 0.9)

    var body: some View {
        
        RoundedRectangle(cornerRadius: 20.0, style: .continuous)
            .foregroundStyle(lightGray)
            .frame(height: 90.0)
            .overlay(StatsView)
            .padding(.horizontal, 50.0)
    }
    
    var StatsView: some View {
        HStack {
            Spacer()
            
            VStack {
                Text("Humidity")
                    .foregroundStyle(.gray)
                    .font(.headline)
                
                Text(weather.humidity)
                    .font(.title2)
            }

            Spacer()
            
            VStack {
                Text("UV")
                    .foregroundStyle(.gray)
                    .font(.headline)
                
                Text(weather.UV)
                    .font(.title2)
            }

            Spacer()
            
            VStack {
                Text("Feels Like")
                    .foregroundStyle(.gray)
                    .font(.headline)
                
                Text(weather.feelsLike)
                    .font(.title2)
            }
            
            Spacer()
        }
    }
}
                     

#Preview {
    let vm = WeatherViewModel(currentWeather: Samples.londonReturnModel, at: Samples.londonLocation, icon: Samples.missingIconImage)
    CityDetails(weather: vm)
}
