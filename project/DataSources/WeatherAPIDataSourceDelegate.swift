//
//  WeatherAPIDataSourceDelegate.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import Foundation

protocol WeatherAPIDataSourceDelegate: AnyObject {
    func currentWeatherInformationLoaded(weatherInformation: CurrentWeatherInformation)
    func currentWeatherInformationFailed(error: Error)
    func fiveDayWeatherInformationLoaded(weatherInformation: FiveDayWeatherInformation)
    func fiveDayWeatherInformationLoaded2(weatherInformation: FiveDayWeatherInformation2)
}
