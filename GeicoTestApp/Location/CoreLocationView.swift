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
    @StateObject var model = CoreLocationModel()
    
    var body: some View {
        GeometryReader { reader in
            VStack {
                Map(coordinateRegion: $model.region,
                    interactionModes: .all,
                    showsUserLocation: true)
                    .frame(width: reader.size.width,
                           height: reader.size.height * 0.7)
                buttonsview
            }
            .alert(item: $model.errorMessage) { error in
                Alert(title: Text("Error"),
                      message: Text(error),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    var buttonsview: some View {
        List {
            HStack {
                Text("Location")
                Spacer()
                Text("\(model.latitude), \(model.longitude)")
                    .monospaced()
            }
            Button(action: {
                model.requestWhenInUseAuthorization()
            },
                   label: {
                Text("Request When In Use")
            })
            .disabled(model.autorizedWhenInUse)
            
            Button(action: {
                model.requestAlwaysAuthorization()
            },
                   label: {
                Text("Request Always")
            })
            .disabled(model.autorizedAlways)

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
}

#Preview {
    CoreLocationView()
}
