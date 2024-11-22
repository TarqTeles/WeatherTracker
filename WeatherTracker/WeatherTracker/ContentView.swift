//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

struct ContentView: View {
    @Bindable var main: MainViewModel
    
    
    private let lightGray = Color(red: 0.9, green: 0.9, blue: 0.9)

    var body: some View {
        NavigationStack {
            VStack {
                if let current = main.currentWeather {
                    VStack {
                        current.icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 173.0, height: 173.0, alignment: .center)
                        
                        Text(current.locationName)
                            .font(.headline)
                            .padding(.bottom, 2.0)
                        
                        Text(current.temperatureCelsius)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .scaleEffect(1.5)
                            .padding(.leading)


                        Spacer()
                    }
                    .padding(.top, 50.0)
                } else {
                    List {
                        ForEach(main.availableLocations) { location in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(location.locationName)
                                        .font(.headline)
                                        .padding(.bottom, 2.0)
                                    Text(location.temperatureCelsius)
                                        .font(.largeTitle)
                                        .fontWeight(.semibold)
                                        .scaleEffect(1.5)
                                        .padding(.leading)
                                }
                                .padding(.leading)
                                
                                Spacer()
                                
                                location.icon
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 123.0, height: 123.0, alignment: .center)
                                    .padding(.trailing)
                            }
                            .onTapGesture(perform: { main.currentWeather = location })
                        }
                        .listRowBackground(lightGray)
                    }
                    .listRowSpacing(20.0)
                }
            }
            .animation(.easeInOut, value: main.currentWeather == nil)
            .searchable(text: $main.seachString, placement: .toolbar, prompt: "Search locations")
        }
    }
}

#Preview {
    @Previewable @State var main = MainViewModel()
    let fetcher = WeatherFetcher(client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)), viewModel: main)
    
    ContentView(main: main)
        .task {
            try? await fetcher.getLocations(for: "Lond")
        }
}
