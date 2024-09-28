//
//  ContentView.swift
//  CoupleApp
//
//  Created by Enes Talha Uçar  on 28.09.2024.
//

import SwiftUI
import CoreLocation

struct CoupleView: View {
//    @State private var location1 : CLLocation = CLLocation(latitude: 41.069175, longitude: 28.887077)
//    @State private var location2 : CLLocation = CLLocation(latitude: 41.024899, longitude: 28.977071)
    @State var locationManager = LocationManager()
    
    @State private var location1Lat = ""
    @State private var location1Long = ""
    @State private var location2Lat = ""
    @State private var location2Long = ""
    @State private var distance : Double = 0
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("User 1 Information") {
                        TextField("Enter your latitude", text: $location1Lat)
                        TextField("Enter your longtitude", text: $location1Long)
                    }
                    
                    Section("User 2 Information") {
                        TextField("Enter friend's latitude", text: $location2Lat)
                        TextField("Enter friend's longtitude", text: $location2Long)
                    }
                    
                    Section("Distance") {
                        Text("Distance: \(String(format: "%.1f", distance / 1000)) km")
                    }
                }
                
                Button {
                    let lat1 = Double(location1Lat)
                    let long1 = Double(location1Long)
                    let lat2 = Double(location2Lat)
                    let long2 = Double(location2Long)
                    
                    let location1 = CLLocation(latitude: lat1!, longitude: long1!)
                    let location2 = CLLocation(latitude: lat2!, longitude: long2!)
                    distance = locationManager.calculateDistance(from: location1, to: location2)
                    print(distance)
                    
                } label: {
                    Text("Calculate Distance")
                        .foregroundStyle(.black)
                }.padding()
                
            }.navigationTitle("Couple App")
        }
    }
}

#Preview {
    CoupleView()
}
