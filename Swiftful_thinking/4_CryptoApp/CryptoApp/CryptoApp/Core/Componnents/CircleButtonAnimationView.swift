//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Mahipal on 26/10/24.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(isAnimating ? 1.0 : 0.0)
            .opacity(isAnimating ? 0.0 : 1.0)
            .animation(
                isAnimating ? .easeInOut(duration: 1.0) : .none,
                value: isAnimating
            )
            
    }
}

#Preview {
    CircleButtonAnimationView(isAnimating: .constant(false))
}
