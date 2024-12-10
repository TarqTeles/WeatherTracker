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
    private let minimumSearchLength = 3

    var body: some View {
        NavigationStack {
            VStack {
                if main.searchString.isEmpty {
                    Spacer()
                    
                    Text("No City Selected")
                        .font(.headline)
                        .padding(.bottom)
                    
                    Text("Please Search for a City")

                } else if let current = main.currentWeather {
                    VStack {
                        current.icon
                            .resizable()
                            .scaledToFit()
                            .frame(width: 173.0, height: 173.0, alignment: .center)
                        
                        Text(current.locationName)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, 2.0)
                        
                        Text(current.temperatureCelsius)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .scaleEffect(1.5)
                            .padding(.bottom)

                        CityDetails(weather: current)
                        
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
                            .onTapGesture(perform: {
                                main.currentWeather = location
                                main.setSelectedCity?(location.locationName)
                            })
                        }
                        .listRowBackground(lightGray)
                    }
                    .listRowSpacing(20.0)
                }
                
                Spacer()
                if let errMsg = main.lastErrorMessage {
                    ZStack {
                        Color.red
                            .frame(height: 100.0)
                        
                        Text(errMsg)
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .refreshable { await main.getLocationsFor?() }
            .animation(.easeInOut, value: main.currentWeather == nil)
            .animation(.bouncy(duration: 2.0, extraBounce: 0.25), value: main.availableLocations.count)
            .searchable(text: $main.searchString, placement: .toolbar, prompt: "Search locations")
            .onChange(of: main.searchString, { _, new in
                main.currentWeather = nil
                main.setSelectedCity?("")
                if new.count >= minimumSearchLength {
                    Task(priority: .background) {
                        await main.getLocationsFor?()
                    }
                } else if new.isEmpty {
                    main.availableLocations = []
                }
            })
        }
    }
}

#Preview {
    @Previewable @State var main = MainViewModel()
    let fetcher = WeatherFetcher(client: URLSessionHTTPClient(session: URLSession(configuration: .ephemeral)), viewModel: main)
    let searchFor = "Lond"
    
    ContentView(main: main)
        .task {
            try? await fetcher.getLocations(for: searchFor)
            main.searchString = searchFor
            main.lastErrorMessage = URLError(.badServerResponse, userInfo: .init()).localizedDescription
        }
}
