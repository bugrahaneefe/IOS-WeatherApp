//
//  WeatherWeeklyViewModel2.swift
//  project
//
//  Created by bugra on 19.01.2024.
//

import Foundation
import SwiftUI

// swiftlint:disable identifier_name
// swiftlint:disable line_length

class WeatherWeeklyViewModel2: ObservableObject {

    @Published var city: String = "Istanbul"
    @Published var isLoading = true
    @Published var weatherList2: [FiveDayWeatherData2] = []
    @Published var dt_txt2: String = ""
    @Published var temp2: Double = 0.0
    @Published var mainWeather2: String = ""
    @Published var weatherInformationList2: [Information2] = []
    private var dataSource2 = WeatherAPIDataSource()
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

    init() {
        dataSource2.delegate = self
    }

    func loadWeatherInformation2(_ city: String) {
        print("viewmodel2 initialized by \(city)")
        if self.weatherInformationList2.isEmpty {
            print(self.weatherInformationList2)
        } else {
            print(self.weatherInformationList2[0].mainWeather2)
        }
        dataSource2.loadFiveDayWeatherInformationOf2(city)
    }

    func weatherSymbol(of weatherType: String) -> Image {
        switch weatherType {
        case "Rain":
            return Image(systemName: "cloud.rain.fill")
        case "Clouds":
            return Image(systemName: "cloud.fill")
        case "Snow":
            return Image(systemName: "cloud.snow")
        case "Wind":
            return Image(systemName: "wind.circle")
        case "Thunder":
            return Image(systemName: "cloud.bolt")
        case "Drizzle":
            return Image(systemName: "cloud.rain")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
}

extension WeatherWeeklyViewModel2: WeatherAPIDataSourceDelegate {
    func fiveDayWeatherInformationLoaded2(weatherInformation: FiveDayWeatherInformation2) {
        isLoading = false
        self.weatherList2 = weatherInformation.list
        if self.weatherInformationList2.isEmpty {
            print(self.weatherInformationList2)
        } else {
            print(self.weatherInformationList2[0].mainWeather2)
        }
        self.weatherInformationList2 = []
        for weatherData in self.weatherList2 {
            self.dt_txt2 = weatherData.dt_txt
            self.temp2 = weatherData.main.temp
            self.mainWeather2 = weatherData.weather.first?.main ?? "Unknown Weather"
            self.weatherInformationList2.append(Information2(dt_txt2: self.dt_txt2, temp2: self.temp2, mainWeather2: self.mainWeather2))
        }
    }

    func currentWeatherInformationFailed(error: Error) {

    }

    func currentWeatherInformationLoaded(weatherInformation: CurrentWeatherInformation) {

    }
    func fiveDayWeatherInformationLoaded(weatherInformation: FiveDayWeatherInformation) {

    }
}

struct Information2 {
    let dt_txt2: String
    let temp2: Double
    let mainWeather2: String
}

// swiftlint:enable identifier_name
// swiftlint:enable line_length
