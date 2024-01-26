//
//  ButtonDS.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

struct ButtonIcon: View {
    private let background: String
    private let icon: String
    private let size: Double
    private let action: () -> Void

    init(background: String, icon: String, size: Double, action: @escaping () -> Void) {
        self.background = background
        self.icon = icon
        self.size = size
        self.action = action
    }

    var body: some View {
        Button(
            action: action
        ) {
            Image(background)
                .overlay(alignment: .center) {
                    Image(systemName: icon)
                        .foregroundStyle(.white)
                        .font(.system(size: size))
                }
        }
        .padding(.vertical, Spacing.spacing_2)
    }
}

#Preview {
    ButtonIcon(background: "elips", icon: "bell", size: 10) { }
}
