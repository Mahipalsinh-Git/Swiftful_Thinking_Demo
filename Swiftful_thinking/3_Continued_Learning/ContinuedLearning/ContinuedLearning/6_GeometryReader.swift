//
//  6_GeometryReader.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 13/09/24.
//

import SwiftUI

struct GeometryReaderDemo: View {

    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }

    var body: some View {
        VStack(spacing: 20) {

            // Ex. 1
            GeometryReader(content: { geometry in
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(.mint)
                        .frame(width: geometry.size.width * 0.66)

                    Rectangle()
                        .fill(.cyan)
                }
                .ignoresSafeArea()
            })

            // Ex. 2
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<20) { intex in
                        GeometryReader(content: { geometry in
                            RoundedRectangle(cornerRadius: 20)
                                .rotation3DEffect(
                                    Angle(degrees: getPercentage(geo: geometry) * 20),
                                    axis: (x: 0.0, y: 1.0, z: 0.0)
                                )
                        })
                        .frame(width: 300, height: 250)
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    GeometryReaderDemo()
}
