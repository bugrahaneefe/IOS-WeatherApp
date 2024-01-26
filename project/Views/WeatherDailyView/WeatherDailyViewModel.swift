//
//  WeatherDailyViewModel.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import Foundation
import SwiftUI

class WeatherDailyViewModel: ObservableObject {

    @Published var city: String = ""
    @Published var isLoading = true
    @Published var isDailySuggestionShown = false
    @Published var isNavigatedtoWeekly: Bool = false
    @Published var showAlert: Bool = false
    @Published var showLogIn: Bool = false
    @Published var weatherInfo: [Weather] = []
    @Published var latitude: Double = 0.0
    @Published var longitude: Double = 0.0
    @Published var tempInfo: MainWeather =
    MainWeather(temp: 0.0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 0, humidity: 0)
    @Published var precipitation: Clouds = Clouds(all: 0)
    @Published var wind: Wind = Wind(speed: 0.0, deg: 0)
    @Published var timeZone: Int = 0
    private var dataSource = WeatherAPIDataSource()
    @Published var errorMessage: String?

    init() {
        dataSource.delegate = self
    }

    func addFavoriteCity(cityInfo: [String: Any]) {
        DataManager.shared.add(cityInfo, to: "favorites")
    }

    func loadWeatherInformation(_ city: String) {
        dataSource.loadCurrentWeatherInformationOf(city)
    }

    func getDateTime(in timeZone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd EEEE"
        formatter.timeZone = timeZone
        let currentDate = Date()
        return formatter.string(from: currentDate)
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

    func dailySuggestion(of weatherType: String) -> String {
        switch weatherType {
        case "Rain":
            return "Do not forget your umbrella!"
        case "Clouds":
            return "Cloudy skies ahead."
        case "Snow":
            return "Bundle up, it's snowing!"
        case "Wind":
            return "Hold onto your hats, it's windy!"
        case "Thunder":
            return "Stay indoors, thunderstorms expected."
        default:
            return "Have an excellent day!"
        }
    }
}

extension WeatherDailyViewModel: WeatherAPIDataSourceDelegate {
    func fiveDayWeatherInformationLoaded2(weatherInformation: FiveDayWeatherInformation2) {

    }

    func fiveDayWeatherInformationLoaded(weatherInformation: FiveDayWeatherInformation) {

    }

    func currentWeatherInformationLoaded(weatherInformation: CurrentWeatherInformation) {
        isLoading = false
        self.latitude = weatherInformation.coord.lat
        self.longitude = weatherInformation.coord.lon
        self.weatherInfo = weatherInformation.weather
        self.tempInfo = weatherInformation.main
        self.timeZone = weatherInformation.timezone
        self.precipitation = weatherInformation.clouds
        self.wind = weatherInformation.wind
    }

    func currentWeatherInformationFailed(error: Error) {
        self.errorMessage = error.localizedDescription
    }
}
