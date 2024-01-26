//
//  SettingsViewModel.swift
//  project
//
//  Created by bugra on 11.01.2024.
//

import Foundation

class SettingsViewModel: ObservableObject {

    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}
