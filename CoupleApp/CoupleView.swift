//
//  ContentView.swift
//  CoupleApp
//
//  Created by Enes Talha Uçar  on 28.09.2024.
//

import SwiftUI
import CoreLocation
import WidgetKit

struct CoupleView: View {
    
//    @State private var location1 : CLLocation = CLLocation(latitude: 41.069175, longitude: 28.887077)
//    @State private var location2 : CLLocation = CLLocation(latitude: 41.024899, longitude: 28.977071)
    @State var locationManager = LocationManager()
    
    @State private var location1Lat = ""
    @State private var location1Long = ""
    @State private var location2Lat = ""
    @State private var location2Long = ""
    @State private var distance : Double = 0
    let sharedDefaults = UserDefaults(suiteName: "group.com.enestalhaucar.CoupleApp")
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section("User 1 Information") {
                        TextField("Enter your latitude", text: $location1Lat)
                            .keyboardType(.decimalPad)
                        TextField("Enter your longtitude", text: $location1Long)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section("User 2 Information") {
                        TextField("Enter friend's latitude", text: $location2Lat)
                            .keyboardType(.decimalPad)
                        TextField("Enter friend's longtitude", text: $location2Long)
                            .keyboardType(.decimalPad)
                    }
                    
                    Section("Distance") {
                        Text("Distance: \(String(format: "%.1f", distance / 1000)) km")
                    }
                }
                
                Button {
                    calculateDistance()
                } label: {
                    Text("Calculate Distance")
                        .foregroundStyle(.black)
                }.padding()
                
            }.navigationTitle("Couple App")
        }
    }
    
    func calculateDistance() {
        guard let lat1 = Double(location1Lat),
              let long1 = Double(location1Long),
              let lat2 = Double(location2Lat),
              let long2 = Double(location2Long) else {
            print("Geçersiz koordinat girdisi")
            distance = 0
            return
        }
        let location1 = CLLocation(latitude: lat1, longitude: long1)
        let location2 = CLLocation(latitude: lat2, longitude: long2)
        
        let calculatedDistance = location1.distance(from: location2)
        
        distance = calculatedDistance
        
        sharedDefaults?.set(calculatedDistance, forKey: "distance")
        
        WidgetCenter.shared.reloadAllTimelines()
        
        print(distance)
    }
}

#Preview {
    CoupleView()
}
