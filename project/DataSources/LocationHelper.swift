//
//  LocationHelper.swift
//  project
//
//  Created by selen bilgiç on 23.01.2024.
//
import CoreLocation
import Foundation

class LocationHelper: NSObject {
    private let locationManager = CLLocationManager()
    weak var delegate: LocationHelperDelegate?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 5
    }

    func getLocation() {
        locationManager.startUpdatingLocation()
    }

    func askForPermission() {
        locationManager.requestAlwaysAuthorization()
    }
}

extension LocationHelper: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.locationReceived(location: locations[0])
    }
}
