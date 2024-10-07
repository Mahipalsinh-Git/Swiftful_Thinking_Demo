//
//  8_MaskDemo.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI

struct MaskDemo: View {

    @State var rating: Int = 3

    var body: some View {
        ZStack {
            starsView
                .overlay {
                    overlayView
                        .mask(starsView)
                }
        }
    }

    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundStyle(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }

    private var starsView: some View {
        HStack {
            ForEach(1 ..< 6) { item in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = item
                        }
                    }
            }
        }
    }

}



#Preview {
    MaskDemo()
}
