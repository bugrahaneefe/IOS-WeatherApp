//
//  MainTitleText.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

struct LargeText: View {
    private let content: String
    private let color: Color

    init(content: String, color: Color) {
        self.content = content
        self.color = color
    }

    var body: some View {
        Text(content)
            .lineLimit(1)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(color)
    }
}

#Preview {
    LargeText(content: "test", color: .red)
}
