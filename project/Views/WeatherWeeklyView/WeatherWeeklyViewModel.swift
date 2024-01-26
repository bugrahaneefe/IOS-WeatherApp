//
//  WeatherWeeklyViewModel.swift
//  project
//
//  Created by bugra on 2.01.2024.
//

import Foundation
import SwiftUI

// swiftlint:disable identifier_name
// swiftlint:disable line_length

class WeatherWeeklyViewModel: ObservableObject {

    @Published var city: String = ""
    @Published var city2: String = ""
    @Published var isLoading = true
    @Published var isComparedToShown = false
    @Published var weatherList: [FiveDayWeatherData] = []
    @Published var dt_txt: String = ""
    @Published var temp: Double = 0.0
    @Published var mainWeather: String = ""
    @Published var weatherInformationList: [Information] = []
    private var dataSource = WeatherAPIDataSource()

    init() {
        dataSource.delegate = self
    }

    func loadWeatherInformation(_ city: String) {
        dataSource.loadFiveDayWeatherInformationOf(city)
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

extension WeatherWeeklyViewModel: WeatherAPIDataSourceDelegate {
    func fiveDayWeatherInformationLoaded2(weatherInformation: FiveDayWeatherInformation2) {

    }

    func currentWeatherInformationFailed(error: Error) {

    }

    func currentWeatherInformationLoaded(weatherInformation: CurrentWeatherInformation) {

    }
    func fiveDayWeatherInformationLoaded(weatherInformation: FiveDayWeatherInformation) {
        isLoading = false
        self.weatherList = weatherInformation.list

        for weatherData in weatherInformation.list {
            self.dt_txt = weatherData.dt_txt
            self.temp = weatherData.main.temp
            self.mainWeather = weatherData.weather.first?.main ?? "Unknown Weather"
            self.weatherInformationList.append(Information(dt_txt: self.dt_txt, temp: self.temp, mainWeather: self.mainWeather))
         }

    }
}

struct Information {
    let dt_txt: String
    let temp: Double
    let mainWeather: String
}

// swiftlint:enable identifier_name
// swiftlint:enable line_length
