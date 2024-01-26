//
//  WeatherAPIDataSource.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import Foundation

// swiftlint:disable unused_closure_parameter
// swiftlint:disable line_length

struct WeatherAPIDataSource {

    private let currentWeatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?q="
    private let fiveDayWeatherBaseURL = "https://api.openweathermap.org/data/2.5/forecast?q="
    private let apiKey = "e232b055b903160f67f40afb3c38451f"
    private let apiKey2 = "e09c02663615b99960853e0d3712465a"
    var delegate: WeatherAPIDataSourceDelegate?

    func loadCurrentWeatherInformationOf(_ city: String) {
        // MARK: Get Shared URL Session
        let session = URLSession.shared

        // MARK: Create URL
        if let url = URL(string: "\(currentWeatherBaseURL)\(city)&appid=\(apiKey)") {

            // MARK: Create URLRequest
            var request = URLRequest(url: url)

            // MARK: Set the http Verb
            request.httpMethod = "GET"

            // MARK: Set header for json
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // MARK: Create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard let data else { return }
                let decoder = JSONDecoder()
                do {
                    let weatherInformation = try decoder.decode(CurrentWeatherInformation.self, from: data)
                    DispatchQueue.main.async {
                        delegate?.currentWeatherInformationLoaded(weatherInformation: weatherInformation)
                    }
                    // print(weatherInformation.main.temp)
                } catch {
                    delegate?.currentWeatherInformationFailed(error: error)
                    print(error)
                }
            }

            // MARK: Resume data task
            dataTask.resume()
        }
    }

    func loadFiveDayWeatherInformationOf(_ city: String) {
        // MARK: Get Shared URL Session
        let session = URLSession.shared

        // MARK: Create URL
        if let url = URL(string: "\(fiveDayWeatherBaseURL)\(city)&appid=\(apiKey)") {

            // MARK: Create URLRequest
            var request = URLRequest(url: url)

            // MARK: Set the http Verb
            request.httpMethod = "GET"

            // MARK: Set header for json
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // MARK: Create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard let data else { return }
                let decoder = JSONDecoder()
                do {
                    let fiveDayWeatherInformation = try decoder.decode(FiveDayWeatherInformation.self, from: data)
                    DispatchQueue.main.async {
                        delegate?.fiveDayWeatherInformationLoaded(weatherInformation: fiveDayWeatherInformation)
                    }
                    // print("this is from data source for city1 \(fiveDayWeatherInformation.list.first?.main.pressure)")
                } catch {
                    print(error)
                }
            }

            // MARK: Resume data task
            dataTask.resume()
        }
    }

    func loadFiveDayWeatherInformationOf2(_ city: String) {
        // MARK: Get Shared URL Session
        let session = URLSession.shared

        // MARK: Create URL
        if let url = URL(string: "\(fiveDayWeatherBaseURL)\(city)&appid=\(apiKey2)") {

            // MARK: Create URLRequest
            var request = URLRequest(url: url)

            // MARK: Set the http Verb
            request.httpMethod = "GET"

            // MARK: Set header for json
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            // MARK: Create data task
            let dataTask = session.dataTask(with: request) { data, response, error in
                guard let data else { return }
                let decoder = JSONDecoder()
                do {
                    let fiveDayWeatherInformation2 = try decoder.decode(FiveDayWeatherInformation2.self, from: data)
                    DispatchQueue.main.async {
                        delegate?.fiveDayWeatherInformationLoaded2(weatherInformation: fiveDayWeatherInformation2)
                    }
                    // print("this is from data source city 2\(fiveDayWeatherInformation2.list.first?.main.pressure)")
                } catch {
                    print(error)
                }
            }

            // MARK: Resume data task
            dataTask.resume()
        }
    }
}

// swiftlint:enable unused_closure_parameter
// swiftlint:enable line_length
