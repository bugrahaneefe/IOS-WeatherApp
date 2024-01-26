//
//  LongText.swift
//  project
//
//  Created by bugra on 24.01.2024.
//

import SwiftUI

struct LongText: View {

    let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .fixedSize(horizontal: false, vertical: true)
            .multilineTextAlignment(.center)
            .lineLimit(15)
    }
}

#Preview {
    LongText(text: "Test")
}
