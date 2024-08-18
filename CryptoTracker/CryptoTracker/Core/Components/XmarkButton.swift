//
//  XmarkButton.swift
//  CryptoTracker
//
//  Created by Rohit Patil on 17/08/24.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.footnote)
        })
    }
}

#Preview {
    XmarkButton()
}

