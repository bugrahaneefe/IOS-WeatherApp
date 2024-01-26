//
//  SignUpView.swift
//  project
//
//  Created by bugra on 17.01.2024.
//

import SwiftUI

// swiftlint:disable line_length
// swiftlint:disable multiple_closures_with_trailing_closure

struct SignUpView: View {

    @ObservedObject private var viewModel = SignUpViewModel()
    @ObservedObject private var dataManager = DataManager()
    @Binding var showLogIn: Bool

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                SubtitleText(
                    content: viewModel.errorMessage,
                    color: .red)
                Spacer()

                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    TextField("Email:", text: $viewModel.email)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(30)
                .padding(.horizontal)
                .padding(.vertical, 30)

                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("Password:", text: $viewModel.password)
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(30)
                .padding(.horizontal)

                Spacer()

                Button(action: {
                    Task {
                        do {
                            try await viewModel.signUp()
                            try await dataManager.setUserInformation()
                            DataManager.shared.fetchUserInformation()
                            showLogIn = false
                            return
                        } catch {
                            viewModel.errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 220, height: 60)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.indigo]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15.0)
                }

                Spacer()
                SubtitleText(content: "You already have an account? Log In", color: .white)
                    .onTapGesture {
                        viewModel.showLogIn.toggle()
                    }
                Spacer()
                NavigationLink(
                    destination: LoginView(showLogIn: $showLogIn),
                    isActive: $viewModel.showLogIn) {
                    EmptyView()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image(
                    .background)
                .backgroundImage
            )
        }
    }
}

#Preview {
    SignUpView(showLogIn: .constant(false))
}

// swiftlint:enable line_length
// swiftlint:enable multiple_closures_with_trailing_closure
