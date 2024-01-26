//
//  LocationViewModel.swift
//  project
//
//  Created by selen bilgiç on 23.01.2024.
//
import CoreLocation
import Foundation
import SwiftUI

class LocationViewModel: ObservableObject {

    @Published var location: CLLocation?
    private let locationHelper = LocationHelper()

    init() {
        locationHelper.delegate = self
    }

    func getLocation() {
        locationHelper.getLocation()
    }

    func askForPermission() {
        locationHelper.askForPermission()
    }
}

extension LocationViewModel: LocationHelperDelegate {
    func locationReceived(location: CLLocation) {
        self.location = location
    }
}
