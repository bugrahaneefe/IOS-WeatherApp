//
//  LocationHelperDelegate.swift
//  project
//
//  Created by selen bilgiç on 23.01.2024.
//
import CoreLocation
import Foundation

protocol LocationHelperDelegate: AnyObject {

    func locationReceived(location: CLLocation)
}
