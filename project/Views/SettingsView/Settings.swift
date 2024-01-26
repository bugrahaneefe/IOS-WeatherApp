//
//  UserView.swift
//  project
//
//  Created by bugra on 11.01.2024.
//

import SwiftUI

struct Settings: View {

    @ObservedObject private var viewModel = SettingsViewModel()
    @Binding var showLogIn: Bool

    var body: some View {
        List {
            // MARK: Log out button
            Button(action: {
                Task {
                    do {
                        try viewModel.logOut()
                        showLogIn = true
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                Text("Log out")
                    .foregroundStyle(Color.buttonTitle)
            })
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    Settings(showLogIn: .constant(false))
}
