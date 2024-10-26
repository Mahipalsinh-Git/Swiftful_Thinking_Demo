//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Mahipal on 26/10/24.
//

import SwiftUI

struct CircleButtonView: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .font(.headline)
            .foregroundStyle(Color.theme.accentColor)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.backgroundColor)
            )
            .shadow(radius: 10, x: 0, y: 0)
            .padding()
        
    }
}

#Preview() {
    CircleButtonView(imageName: "plus")
}
