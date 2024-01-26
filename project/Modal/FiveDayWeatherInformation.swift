//
//  FiveDayWeatherInformation.swift
//  project
//
//  Created by bugra on 4.01.2024.
//

import Foundation

// swiftlint:disable identifier_name

struct FiveDayWeatherInformation: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [FiveDayWeatherData]
    let city: FiveDayCity
}

struct FiveDayWeatherData: Codable {
    let dt: TimeInterval
    let main: FiveDayMainWeather
    let weather: [FiveDayWeather]
    let clouds: FiveDayClouds
    let wind: FiveDayWind
    let visibility: Int
    let pop: Double
    let rain: FiveDayRain?
    let sys: FiveDaySys
    let dt_txt: String
}

struct FiveDayMainWeather: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}

struct FiveDayWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct FiveDayClouds: Codable {
    let all: Int
}

struct FiveDayWind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct FiveDayRain: Codable {
    let threeh: Double?
}

struct FiveDaySys: Codable {
    let pod: String
}

struct FiveDayCity: Codable {
    let id: Int
    let name: String
    let coord: FiveDayCoordinate
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

struct FiveDayCoordinate: Codable {
    let lat: Double
    let lon: Double
}
// swiftlint:enable identifier_name
