//
//  ImageComponents.swift
//  project
//
//  Created by bugra on 7.01.2024.
//

import SwiftUI

extension Image {
    var backgroundImage: some View {
        self.resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    static let background = "background"
}
