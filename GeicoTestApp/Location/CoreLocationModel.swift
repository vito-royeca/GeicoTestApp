//
//  CoreLocationManager.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import Foundation
import CoreLocation
import MapKit

@MainActor
class CoreLocationModel: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var locationMonitored = false
    @Published var latitude:CLLocationDegrees = 0
    @Published var longitude:CLLocationDegrees = 0
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0,
                                                                              longitude: 0),
                                               span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    @Published var errorMessage: String?


    private var locationManager: CLLocationManager?
    
    func requestWhenInUseAuthorization() {
        initLocationManager()
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func startLocationUpdates() {
        initLocationManager()
        locationManager?.startUpdatingLocation()
    }
    
    func stopLocationUpdates() {
        initLocationManager()
        locationManager?.stopUpdatingLocation()
    }

    private func initLocationManager() {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.allowsBackgroundLocationUpdates = true
            locationManager?.showsBackgroundLocationIndicator = true
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }
    }
}

extension CoreLocationModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = manager.authorizationStatus

        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager?.requestLocation()
            locationManager?.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager?.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        region.center = CLLocationCoordinate2D(latitude: latitude,
                                               longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.errorMessage = error.localizedDescription
    }
}

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
