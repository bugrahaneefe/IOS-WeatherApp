//
//  StartViewModel.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import Foundation
import SwiftUI
import Firebase
import MapKit

class StartViewModel: ObservableObject {

    @Published var mapCameraPosition: MapCameraPosition = .automatic
    @Published var isLoading: Bool = true
    @Published var searchedCity: String = ""
    @Published var selectedCity: String = ""
    @Published var isSearched: Bool = false
    @Published var isHelpSheetShown = false
    @Published var isSettingsShown = false
    @Published var isMapShown = false
    @Published var cities: [[String: Any]] = [
        ["City Name": "Antalya", "Longitude": 30.7178, "Latitude": 36.7741],
        ["City Name": "Amsterdam", "Longitude": 4.897051689693402, "Latitude": 52.37056018714137],
        ["City Name": "Bratislava", "Longitude": 17.1067, "Latitude": 48.1482]
    ]

    @Published var mapCityName: String = ""
    @Published var mapCityLat: Double = 0.0
    @Published var mapCityLon: Double = 0.0

    @Published var APIcities: [String] = [
        "Amsterdam",
        "Athens",
        "Bratislava",
        "Brussels",
        "Bucharest",
        "Budapest",
        "Copenhagen",
        "Dublin",
        "Helsinki",
        "Lisbon",
        "Ljubljana",
        "London",
        "Luxembourg City",
        "Madrid",
        "Nicosia",
        "Paris",
        "Prague",
        "Riga",
        "Rome",
        "Sofia",
        "Stockholm",
        "Tallinn",
        "Valletta",
        "Vienna",
        "Vilnius",
        "Warsaw",
        "Adana",
        "Ankara",
        "Antalya",
        "Bursa",
        "Gaziantep",
        "Istanbul",
        "Izmir",
        "Kayseri",
        "Konya",
        "Mersin"
    ]

    func getFavoriteCities() async throws -> [[String: Any]] {
        guard let actualUserId = Auth.auth().currentUser?.uid else {
            return []
        }

        return DataManager.shared.userInformation
            .filter { $0.id.contains(actualUserId) }
            .flatMap({$0 .favorites})
    }

    init() {
        Task {
            do {
                self.cities = try await getFavoriteCities()
                print("favorite cities got")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    var APIResults: [String] {
        if self.searchedCity.isEmpty {
            return self.APIcities
        } else {
            return self.APIcities.filter { $0.contains(self.searchedCity) }
        }
    }
}
