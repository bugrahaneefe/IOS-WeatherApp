//
//  ButtonIconText.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

struct ButtonIconSideText: View {
    private let title: String
    private let subTitle: String
    private let icon: String
    private let action: () -> Void

    init(title: String, subTitle: String, icon: String, action: @escaping () -> Void) {
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(
            action: action
        ) {
            Image("rectangle3")
                .overlay {
                    HStack(
                        spacing: Spacing.spacing_2) {
                        Spacer()
                        Image(systemName: icon)
                            .foregroundStyle(.white)
                            .imageScale(.medium)
                        VStack {
                            TitleText(content: title,
                                      color: .white)
                            SubtitleText(content: subTitle,
                                         color: .white)
                        }
                        Spacer()
                        Spacer()
                    }
                }
        }
        .padding(.vertical, Spacing.spacing_1)
    }
}

#Preview {
    ButtonIconSideText(title: "test", subTitle: "tesst", icon: "bell") {}
}
