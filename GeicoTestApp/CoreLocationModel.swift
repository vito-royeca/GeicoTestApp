//
//  CoreLocationManager.swift
//  GeicoTestApp
//
//  Created by Vito Royeca on 11/4/23.
//

import Foundation
import CoreLocation
import MapKit

class CoreLocationModel: NSObject, ObservableObject {
    @Published var autorizedWhenInUse = false
    @Published var autorizedAlways = false
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
    
    func requestAlwaysAuthorization() {
        initLocationManager()

        if !autorizedWhenInUse {
            requestWhenInUseAuthorization()
        }
        locationManager?.requestAlwaysAuthorization()
    }

    func startLocationUpdates() {
        initLocationManager()
        locationManager?.startUpdatingLocation()
        locationMonitored = true
    }
    
    func stopLocationUpdates() {
        initLocationManager()
        locationManager?.stopUpdatingLocation()
        locationMonitored = false
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
        switch manager.authorizationStatus {
        case .notDetermined:
            print("When user did not yet determined")
        case .restricted:
            print("Restricted by parental control")
        case .denied:
            print("When user select option Dont't Allow")
        case .authorizedWhenInUse:
            print("When user select option Allow While Using App or Allow Once")
            autorizedWhenInUse = true
            locationManager?.requestLocation()
        case .authorizedAlways:
            print("When user select option Change to Always Allow")
            autorizedAlways = true
            locationManager?.requestLocation()
        default:
            print("default")
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
