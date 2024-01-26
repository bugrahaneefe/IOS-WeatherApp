//
//  SubtitleText.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

struct SubtitleText: View {

    private let content: String
    private let color: Color

    init(content: String, color: Color) {
        self.content = content
        self.color = color
    }

    var body: some View {
        Text(content)
            .lineLimit(1)
            .fixedSize(horizontal: true, vertical: false)
            .font(.subheadline)
            .fontWeight(.light)
            .foregroundColor(color)
    }
}

#Preview {
    SubtitleText(content: "Text", color: .red)
}
