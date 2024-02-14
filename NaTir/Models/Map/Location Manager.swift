//
//  Location Manager.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import Foundation
import MapKit

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate
{
    var locationManager: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 45.8, longitude: 15.6), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
    @Published var areLocationServicesEnabled: Bool = false
    
    func checkIfLocationServicesEnabled() -> Void
    {
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.activityType = .otherNavigation
            locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters
        }
        else
        {
            print("User disabled location services for their entire device")
        }
    }
    
    private func checkLocationAuthorization() -> Void
    {
        guard let locationManager else
        {
            return
        }
        
        switch locationManager.authorizationStatus
        {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                
            case .restricted:
                print("Restricted due to parental controls")
                
            case .denied:
                print("Authorization denied. Tell them to the settings to enable it")
                
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: locationManager.location!.coordinate.latitude,
                        longitude: locationManager.location!.coordinate.longitude),
                    latitudinalMeters: 5000,
                    longitudinalMeters: 5000)
                self.areLocationServicesEnabled = true
                
            @unknown default:
                break
                
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
