//
//  FiveDayWeatherInformation2.swift
//  project
//
//  Created by bugra on 19.01.2024.
//

import Foundation

// swiftlint:disable identifier_name

struct FiveDayWeatherInformation2: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [FiveDayWeatherData2]
    let city: FiveDayCity2
}

struct FiveDayWeatherData2: Codable {
    let dt: TimeInterval
    let main: FiveDayMainWeather2
    let weather: [FiveDayWeather2]
    let clouds: FiveDayClouds2
    let wind: FiveDayWind2
    let visibility: Int
    let pop: Double
    let rain: FiveDayRain2?
    let sys: FiveDaySys2
    let dt_txt: String
}

struct FiveDayMainWeather2: Codable {
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

struct FiveDayWeather2: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct FiveDayClouds2: Codable {
    let all: Int
}

struct FiveDayWind2: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct FiveDayRain2: Codable {
    let threeh: Double?
}

struct FiveDaySys2: Codable {
    let pod: String
}

struct FiveDayCity2: Codable {
    let id: Int
    let name: String
    let coord: FiveDayCoordinate2
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

struct FiveDayCoordinate2: Codable {
    let lat: Double
    let lon: Double
}

// swiftlint:enable identifier_name
