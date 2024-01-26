//
//  ContentView.swift
//  project
//
//  Created by bugra on 1.01.2024.
//
import SwiftUI

struct WelcomeView: View {
    @StateObject private var viewModel = WelcomeViewModel()
    @StateObject private var viewModelLoc = LocationViewModel()
    @State var showLogIn: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    ButtonIcon(background: "elips",
                               icon: "sun.max.fill",
                               size: 75) {
                        viewModelLoc.askForPermission()
                        viewModel.isNavigated.toggle()
                    }
                    SubtitleText(content: "MyWeatherApp",
                                 color: .black)
                    NavigationLink(
                        destination: StartView(showLogIn: $showLogIn),
                        isActive: $viewModel.isNavigated) {
                        EmptyView()
                    }
                }
                .navigationTitle("WELCOME")
                .navigationBarTitleDisplayMode(.inline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(
                    .background)
                .backgroundImage
            )
        }
        .onAppear {
            let authUser = try?  AuthenticationManager.shared.getAuthenticatedUser()
            showLogIn = authUser == nil
            print(showLogIn)
            print(authUser?.email)
        }
        .fullScreenCover(isPresented: $showLogIn, content: {
            NavigationStack {
                LoginView(showLogIn: $showLogIn)
            }
        })
        .tint(.black)
    }
}

#Preview {
    WelcomeView()
}
