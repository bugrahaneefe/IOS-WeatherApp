//
//  WeatherDailyView.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

struct WeatherDailyView: View {

    @ObservedObject private var viewModel = WeatherDailyViewModel()

    init(city: String) {
        viewModel.city = city
    }

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    VStack {
                        // MARK: Loading Page
                        LoadingIndicator()
                            .onAppear {
                                viewModel.loadWeatherInformation(viewModel.city)
                            }
                        // MARK: If data does not exist
                        if let errorMessage = viewModel.errorMessage {
                            ErrorText(content: errorMessage)
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        // MARK: Weather Description
                        Text(viewModel.weatherInfo.first?.main ?? "Unknown Weather") .foregroundColor(.white)
                            .font(.system(size: 25))
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        // MARK: Weather Symbol
                        viewModel.weatherSymbol(of: viewModel.weatherInfo.first?.main ?? "sun.max.fill")
                            .foregroundStyle(.white)
                            .font(.system(size: 100))
                            .padding(.vertical, 8)
                        temperatureView
                        timeDateView
                        weatherDetailView
                        bottomBarView
                        NavigationLink(
                            destination: WeatherWeeklyView(city: viewModel.city),
                            isActive: $viewModel.isNavigatedtoWeekly) {
                            EmptyView()
                        }
                    }
                    .navigationTitle(
                        viewModel.city
                            .capitalized
                    )
                    .navigationBarTitleDisplayMode(.large)
                    .toolbar {
                        Button("Add") {
                            viewModel.addFavoriteCity(cityInfo: [
                                "City Name": viewModel.city.capitalized,
                                "Latitude": viewModel.latitude,
                                "Longitude": viewModel.longitude
                            ])
                            DataManager.shared.fetchUserInformation()
                            viewModel.showAlert.toggle()
                            print("added if new & fetched")
                        }
                    }
                    .alert(isPresented: $viewModel.showAlert) {
                        Alert(
                            title: Text("Successfully Added!"),
                            message: Text("The city has been added to your favorites."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .toolbarBackground(.hidden, for: .navigationBar)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(
                    .background)
                .backgroundImage
            )
            .sheet(isPresented: $viewModel.isDailySuggestionShown, content: {
                SubtitleText(content: viewModel.dailySuggestion(of: viewModel.weatherInfo.first?.main ?? "Sunny"),
                             color: .purple)
                    .presentationDetents([.medium, .large])
                    .presentationDetents([.height(300), .fraction(0.15)])
            })
        }
        .tint(.black)
    }

    private var degreeView: some View {
        VStack {
            Image("degree")
            Spacer()
        }
        .frame(width: 5, height: 40)
    }

    private var temperatureView: some View {
        HStack {
            LargeText(content: (String(Int(viewModel.tempInfo.temp-273))),
                      color: .white)
            degreeView
        }
    }

    private var timeDateView: some View {
        VStack {
            if let timeZone = TimeZone(secondsFromGMT: viewModel.timeZone) {
                Text(viewModel.getDateTime(in: timeZone))
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
    }

    private var weatherDetailView: some View {
        VStack {
            VStack {
                // MARK: Presentation of Precipitation
                ButtonIcon(background: "rectangle2",
                           icon: "umbrella.percent.fill",
                           size: 30,
                           action: {})
                TitleText(content:
                            "\(viewModel.precipitation.all)%",
                          color: .white)
                SubtitleText(content:
                                "Precipitation",
                             color: .white)
            }
            HStack(spacing: 50) {
                VStack {
                    // MARK: Presentation of Humidity
                    ButtonIcon(background:
                                "rectangle2",
                               icon: "humidity.fill",
                               size: 30,
                               action: {})
                    TitleText(content:
                                "\(viewModel.tempInfo.humidity)%",
                              color: .white)
                    SubtitleText(content:
                                    "Humidity",
                                 color: .white)
                }
                VStack {
                    // MARK: Presentation of Wind
                    ButtonIcon(background:
                                "rectangle2",
                               icon: "wind",
                               size: 30,
                               action: {})
                    TitleText(content:
                                "\(viewModel.wind.speed) km/h",
                              color: .white)
                    SubtitleText(content:
                                    "Wind",
                                 color: .white)
                }
            }
            Spacer()
        }
    }

    private var bottomBarView: some View {
        VStack {
            HStack {
                ButtonIconSideText(title:
                                    "Daily",
                                   subTitle: "Suggestion",
                                   icon: "bell",
                                   action: {
                    viewModel.isDailySuggestionShown.toggle()
                })
                .padding()
                Spacer()
                ButtonIconSideText(title:
                                    "5-day",
                                   subTitle: "Forecasts",
                                   icon: "sun.max.fill",
                                   action: {
                    viewModel.isNavigatedtoWeekly.toggle()
                })
                .padding()
            }
        }
    }
}

#Preview {
    WeatherDailyView(city: "london")
}
