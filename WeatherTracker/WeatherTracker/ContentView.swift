//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 22/11/24.
//

import SwiftUI

struct ContentView: View {
    let main: MainViewModel

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        
        List {
            ForEach(main.availableLocations) { location in
                Text(location.locationName)
            }
        }
    }
}

#Preview {
    ContentView(main: MainViewModel())
}
