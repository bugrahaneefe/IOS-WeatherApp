//
//  StartView.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI
import Firebase
import MapKit

// swiftlint:disable line_length

struct StartView: View {

    @ObservedObject private var viewModel = StartViewModel()
    @StateObject private var viewModelLoc = LocationViewModel()
    @Binding var showLogIn: Bool

    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.isLoading {
                    VStack {
                        ErrorText(content: "If something is mistaken, please refresh!")
                        LoadingIndicator()
                            .onAppear {
                                refresh()
                            }
                    }
                } else {
                    if viewModel.isMapShown {
                        VStack {
                            Spacer()
                            Map(position: $viewModel.mapCameraPosition) {
                                    Annotation(
                                        viewModel.mapCityName,
                                        coordinate: .init(
                                            latitude: viewModel.mapCityLat,
                                            longitude: viewModel.mapCityLon
                                        )
                                    ) {
                                        Image(systemName: "bookmark.circle.fill")
                                            .symbolEffect(.pulse)
                                    }
                                    if let userLocation = viewModelLoc.location {
                                        Annotation(
                                            "",
                                            coordinate: .init(
                                                latitude: userLocation.coordinate.latitude,
                                                longitude: userLocation.coordinate.longitude
                                            )
                                        ) {
                                            Image(systemName: "location.circle")
                                                .symbolEffect(.pulse)
                                        }
                                    }
                                }
                                .onAppear {
                                    viewModel.mapCameraPosition = .camera(
                                        .init(
                                            centerCoordinate: .init(
                                                latitude: viewModel.mapCityLat,
                                                longitude: viewModel.mapCityLon
                                            ),
                                            distance: .infinity,
                                            heading: 0,
                                            pitch: 0
                                        )
                                    )
                                }
                                .clipShape(.buttonBorder)
                            Button {
                                viewModel.isMapShown.toggle()

                            } label: {
                                SubtitleText(content: "Close", color: .white)
                                    .padding()
                            }
                            .background(Color.purple)
                            .clipShape(.buttonBorder)
                            Spacer()
                        }
                    }
                    ScrollView {
                        if !viewModel.cities.isEmpty {
                            ForEach(viewModel.cities.indices, id: \.self) { index in
                                if let cityInfo = viewModel.cities[index] as? [String: Any],
                                   let cityName = cityInfo["City Name"] as? String,
                                   let cityLat = cityInfo["Latitude"] as? Double,
                                   let cityLon = cityInfo["Longitude"] as? Double {
                                    HStack {
                                        HStack {
                                            TitleText(content: cityName, color: .white)
                                        }
                                        .padding()
                                        ButtonIcon(background: "rectangle1", icon: "location.circle.fill", size: 20) {
                                            viewModel.selectedCity = cityName
                                            viewModel.isSearched.toggle()
                                        }
                                        Spacer()
                                        VStack {
                                            // MARK: Map button
                                            ButtonIcon(background:
                                                        "rectangle1",
                                                       icon: "map.circle",
                                                       size: 30) {
                                                viewModel.mapCityName = cityName
                                                viewModel.mapCityLon = cityLon
                                                viewModel.mapCityLat = cityLat
                                                viewModelLoc.getLocation()
                                                viewModel.isMapShown.toggle()
                                            }
                                        }
                                        .padding()
                                    }
                                    .background(
                                        Image("rectangle3")
                                            .resizable()
                                            .frame(width: 350, height: 75)
                                    )
                                    .onTapGesture {
                                        viewModel.selectedCity = cityName
                                        viewModel.isSearched.toggle()
                                    }
                                    .padding()
                                }
                            }
                            .listRowSeparator(.hidden, edges: .all)
                            .navigationTitle("Search for City")
                            .navigationBarTitleDisplayMode(.inline).listRowSeparator(.hidden, edges: .all)
                            .navigationTitle("Search for City")
                            .navigationBarTitleDisplayMode(.inline)
                        } else {
                            ErrorText(content: "Your favorite cities go here!, if something wrong please refresh.")
                                .navigationTitle("Search for City")
                                .navigationBarTitleDisplayMode(.inline)
                                .searchable(text: $viewModel.searchedCity,
                                            placement: .navigationBarDrawer(displayMode: .automatic),
                                            prompt: "Search for City")
                                .onSubmit(of: .search) {
                                    viewModel.selectedCity = viewModel.searchedCity
                                    viewModel.isSearched.toggle()
                                }
                        }
                    }
                }
                Spacer()
                HStack {
                    VStack {
                        // MARK: Help button
                        ButtonIcon(background:
                                    "rectangle1",
                                   icon: "questionmark.circle.fill",
                                   size: 30) {
                            viewModel.isHelpSheetShown.toggle()
                        }
                        SubtitleText(content:
                                        "Help",
                                     color: .white)
                    }
                    .padding()
                    Spacer()
                    HStack {
                        VStack {
                            // MARK: Settings button
                            ButtonIcon(background:
                                        "rectangle1",
                                       icon: "gear",
                                       size: 30) {
                                viewModel.isSettingsShown.toggle()
                            }
                            SubtitleText(content:
                                            "Settings",
                                         color: .white)
                        }
                    }
                    .padding()

                }
                .padding()
                .frame(height: 50)
            }
            .onAppear(perform: {
                refresh()
            })
            .onTapGesture(perform: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
            .toolbar {
                Button {
                    refresh()
                } label: {
                    Image(systemName: "arrow.clockwise.circle.fill")
                }
            }
            .sheet(isPresented: $viewModel.isHelpSheetShown, content: {
                VStack {
                    TitleText(content: "Help Screen", color: .purple)
                    LongText(text: "Explore the world with ease using our intuitive weather app. Discover real-time weather updates, and stay informed about your favorite cities. Our app ensures you're always prepared for the elements.")
                        .foregroundStyle(.purple)
                }
                .presentationDetents([.large])
                .presentationDetents([.height(1200), .fraction(0.2)])
            })
            .navigationBarBackButtonHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(
                    .background)
                .backgroundImage
            )
            .toolbarBackground(.hidden, for: .navigationBar)
            .searchable(text: $viewModel.searchedCity,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search for City") {
                ForEach(viewModel.APIResults, id: \.self) { city in
                    Text(city)
                        .onTapGesture {
                            viewModel.selectedCity = city
                            viewModel.isSearched.toggle()
                        }

                }
            }
                        .onSubmit(of: .search) {
                            viewModel.selectedCity = viewModel.searchedCity
                            viewModel.isSearched.toggle()
                        }
            NavigationLink(
                destination: WeatherDailyView(city: viewModel.selectedCity.lowercased()),
                isActive: $viewModel.isSearched) {
                EmptyView()
            }

            NavigationLink(
                destination: Settings(showLogIn: $showLogIn),
                isActive: $viewModel.isSettingsShown) {
                EmptyView()
            }
        }

        .tint(.black)
    }

    func refresh() {
        Task {
            do {
                viewModel.cities = try await viewModel.getFavoriteCities()
                if !viewModel.cities.isEmpty {
                    viewModel.isLoading = false
                } else {
                    viewModel.isLoading = true
                }
                // print(viewModel.isLoading)
                return
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    StartView(showLogIn: .constant(false))
}

// swiftlint:enable line_length
