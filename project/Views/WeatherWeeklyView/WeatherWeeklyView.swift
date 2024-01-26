//
//  WeatherWeeklyView.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

// swiftlint:disable identifier_name

struct WeatherWeeklyView: View {

    @ObservedObject private var viewModel = WeatherWeeklyViewModel()
    @ObservedObject private var viewModel2 = WeatherWeeklyViewModel2()

    init(city: String) {
        viewModel.city = city
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    if viewModel.isLoading || viewModel2.isLoading {
                        // MARK: Loading Page
                        LoadingIndicator()
                            .onAppear {
                                viewModel2.loadWeatherInformation2(viewModel2.city)
                                viewModel.loadWeatherInformation(viewModel.city)
                            }
                    } else {
                        VStack {
                            HStack {
                                todayWeatherView
                                todayWeatherView2
                            }
                            .padding(.top, 120)
                            VStack {
                                weatherViewAt(indexOf: 8)
                                weatherViewAt(indexOf: 16)
                                weatherViewAt(indexOf: 24)
                                weatherViewAt(indexOf: 32)
                            }
                            .padding(.bottom, 100)
                        }
                        .toolbar {
                            Button(action: {
                                viewModel.isComparedToShown = true
                            }, label: {
                                Image(systemName: "mail.and.text.magnifyingglass")
                                    .foregroundStyle(.white)
                                SubtitleText(content: "Compare to", color: .white)
                            })
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Image(
                        .background)
                    .backgroundImage
                )
                .toolbarBackground(.hidden, for: .navigationBar)
                if viewModel.isComparedToShown {
                    VStack {
                        SubtitleText(content: "Select a city to compare:",
                                     color: .black)
                        Picker("Select a city", selection: $viewModel2.city) {
                            ForEach(viewModel2.APIcities, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        SubtitleText(content: "Selected city: \(viewModel2.city)", color: .black)
                        TitleText(content: "OK", color: .black)
                            .onTapGesture {
                                viewModel.isComparedToShown.toggle()
                                viewModel.isLoading.toggle()
                                viewModel2.isLoading.toggle()
                            }
                    }
                    .padding()
                    .background(Color.white)
                    .clipShape(.buttonBorder)
                }
            }
        }
        .tint(.black)
    }

    private var degreeView: some View {
        VStack {
            Image("degree")
            Spacer()
        }
        .frame(width: 5, height: 45)
    }

    private var todayWeatherView: some View {
        VStack {
            LargeText(content: viewModel.city.capitalized, color: .white)
            viewModel.weatherSymbol(of: viewModel.weatherInformationList[0].mainWeather)
                .foregroundStyle(.white)
                .font(.system(size: 50))
            HStack {
                HStack {
                    LargeText(content: String(Int(viewModel.weatherInformationList[1].temp - 273)),
                              color: .white)
                    degreeView
                }
            }
            .padding()
        }
        .padding()
    }

    private var todayWeatherView2: some View {
        VStack {
            LargeText(content: viewModel2.city.capitalized, color: .white)
            viewModel2.weatherSymbol(of: viewModel2.weatherInformationList2[0].mainWeather2)
                .foregroundStyle(.white)
                .font(.system(size: 50))
            HStack {
                HStack {
                    LargeText(content: String(Int(viewModel2.weatherInformationList2[1].temp2 - 273)), color: .white)
                    degreeView
                }
            }
            .padding()

        }
        .padding()
    }

    private func weatherViewAt(indexOf i: Int) -> some View {
        VStack {
            SubtitleText(content: viewModel.weatherInformationList[8].dt_txt, color: .white)
            HStack {
                HStack {
                    VStack {
                        viewModel.weatherSymbol(of: viewModel.weatherInformationList[i].mainWeather)
                            .foregroundStyle(.white)
                            .font(.system(size: 40))
                        TitleText(content: viewModel.weatherInformationList[i].mainWeather, color: .white)
                    }
                    HStack {
                        LargeText(content: String(Int(viewModel.weatherInformationList[i].temp - 273)),
                                  color: .white)
                        degreeView
                    }
                }
                .padding()
                HStack {
                    Text("|")
                        .foregroundStyle(.white)
                }
                HStack {
                    VStack {
                        viewModel2.weatherSymbol(of: viewModel2.weatherInformationList2[i].mainWeather2)
                            .foregroundStyle(.white)
                            .font(.system(size: 40))
                        TitleText(content: viewModel2.weatherInformationList2[i].mainWeather2, color: .white)
                    }
                    HStack {
                        LargeText(content: String(Int(viewModel2.weatherInformationList2[i].temp2 - 273)),
                                  color: .white)
                        degreeView
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    WeatherWeeklyView(city: "london")
}

// swiftlint:enable identifier_name
