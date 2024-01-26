//
//  LoginViewModel.swift
//  project
//
//  Created by bugra on 11.01.2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var showSignUp: Bool = false

    func signIn() async throws {
        try await AuthenticationManager.shared.signIn(email: email, password: password)
    }
}
