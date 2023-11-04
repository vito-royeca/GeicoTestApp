//
//  CoreLocationView.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct CoreLocationView: View {
    @EnvironmentObject var model: CoreLocationModel
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                switch model.authorizationStatus {
                case .notDetermined:
                    Text("Location Permissions not determined")
                case .restricted:
                    Text("Location Permissions restricted")
                    settingsButton
                case .denied:
                    Text("Location Permissions deneid")
                    settingsButton
                case .authorizedAlways,
                        .authorizedWhenInUse,
                        .authorized:
                    mapView
                        .frame(height: reader.size.height * 0.7)
                    listView
                @unknown default:
                    Text("Location Permissions unknown")
                        .font(.title)
                }
                
            }
            .frame(width: reader.size.width)
            .alert(item: $model.errorMessage) { error in
                Alert(title: Text("Error"),
                      message: Text(error),
                      dismissButton: .default(Text("OK")))
            }
            .onAppear {
                model.requestWhenInUseAuthorization()
            }
        }
    }
    
    var mapView: some View {
        Map(coordinateRegion: $model.region,
            interactionModes: .all,
            showsUserLocation: true)
            
    }

    var listView: some View {
        List {
            HStack {
                Text("Location")
                Spacer()
                Text("\(model.latitude), \(model.longitude)")
                    .monospaced()
            }

            Toggle("Location Updates",
                   isOn: $model.locationMonitored)
                .onChange(of: model.locationMonitored,
                          initial: false) {
                    if model.locationMonitored {
                        model.stopLocationUpdates()
                    } else {
                        model.startLocationUpdates()
                    }
                }
        }
        .listStyle(.plain)
    }
    
    var settingsButton: some View {
        Button(action: {
            if let url = URL(string:UIApplication.openSettingsURLString),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }, label: {
            Text("Open App Settings")
        })
    }
}

#Preview {
    let model = CoreLocationModel()

    return CoreLocationView()
        .environmentObject(model)
}
