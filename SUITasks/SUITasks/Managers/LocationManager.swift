//
//  LocationManager.swift
//  SUITasks
//
//  Created by user on 25.06.2024.
//

import Combine
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject{
    
    var currentLocation = PassthroughSubject<CLLocation?, Never>()
  
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true

        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
  
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation.send(locations.last)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        if let clError = error as? CLError {
            switch clError.code {
            case .locationUnknown, .denied, .network:
                print("Location request failed with error: \(clError.localizedDescription)")
            case .headingFailure:
                print("Heading request failed with error: \(clError.localizedDescription)")
            case .rangingUnavailable, .rangingFailure:
                print("Ranging request failed with error: \(clError.localizedDescription)")
            case .regionMonitoringDenied, .regionMonitoringFailure, .regionMonitoringSetupDelayed, .regionMonitoringResponseDelayed:
                print("Region monitoring request failed with error: \(clError.localizedDescription)")
            default:
                print("Unknown location manager error: \(clError.localizedDescription)")
            }
        } else {
            print("Unknown error occurred while handling location manager error: \(error.localizedDescription)")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
}
