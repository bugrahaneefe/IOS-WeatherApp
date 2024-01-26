//
//  ErrorText.swift
//  project
//
//  Created by bugra on 18.01.2024.
//

import SwiftUI

struct ErrorText: View {
    private let content: String

    init(content: String) {
        self.content = content
    }

    var body: some View {
        Text(content)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .font(.subheadline)
            .fontWeight(.light)
            .foregroundColor(.accentColor)
    }
}

#Preview {
    ErrorText(content: "test")
}
