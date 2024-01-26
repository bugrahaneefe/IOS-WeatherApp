//
//  LoadingIndicator.swift
//  project
//
//  Created by bugra on 1.01.2024.
//

import SwiftUI

struct LoadingIndicator: View {

    var body: some View {
        VStack(spacing: Spacing.spacing_1) {
            ProgressView()
            Text("Loading...")
        }
    }
}

#Preview {
    LoadingIndicator()
}
