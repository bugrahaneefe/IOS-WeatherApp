//
//  SignUpViewModel.swift
//  project
//
//  Created by bugra on 17.01.2024.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String = ""
    @Published var showLogIn: Bool = false

    func signUp() async throws {
       try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}
