//
//  LoginView.swift
//  project
//
//  Created by bugra on 11.01.2024.
//

import SwiftUI
import Firebase

// swiftlint:disable line_length
// swiftlint:disable multiple_closures_with_trailing_closure

struct LoginView: View {

    @ObservedObject private var viewModel = LoginViewModel()
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
                            try await viewModel.signIn()
                            showLogIn = false
                            return
                        } catch {
                            viewModel.errorMessage = error.localizedDescription
                        }
                    }
                }) {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 220, height: 60)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.indigo]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(15.0)
                }
                Spacer()

                SubtitleText(content: "Don't you have an account? Sign In", color: .white)
                    .onTapGesture {
                        viewModel.showSignUp.toggle()
                    }
                Spacer()

                NavigationLink(
                    destination: SignUpView(showLogIn: $showLogIn),
                    isActive: $viewModel.showSignUp) {
                    EmptyView()
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Login")
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
    LoginView(showLogIn: .constant(false))
}

// swiftlint:enable line_length
// swiftlint:enable multiple_closures_with_trailing_closure
