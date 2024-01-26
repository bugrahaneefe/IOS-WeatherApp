//
//  WeatherInformation.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import Foundation

// swiftlint:disable identifier_name

struct CurrentWeatherInformation: Codable {
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: MainWeather
    let visibility: Int?
    let wind: Wind
    let clouds: Clouds
    let dt: TimeInterval?
    let sys: System?
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int?
}

struct Coordinate: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainWeather: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

struct Clouds: Codable {
    let all: Int
}

struct System: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

// swiftlint:enable identifier_name
