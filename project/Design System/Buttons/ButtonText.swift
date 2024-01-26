//
//  ButtonText.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

struct ButtonText: View {
    private let title: String
    private let action: () -> Void

    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(
            action: action
        ) {
            Image("rectangle4")
                .overlay {
                    HStack {
                        LargeText(content: title, color: .white)
                            .padding()
                        Spacer()
                    }
                }
        }
        .padding(.vertical, Spacing.spacing_2)
    }
}

#Preview {
    ButtonText(title: "test", action: {})
}
