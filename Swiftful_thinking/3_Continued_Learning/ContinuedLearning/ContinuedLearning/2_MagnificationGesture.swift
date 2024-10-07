//
//  2_MagnificationGesture.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 21/08/24.
//

import SwiftUI

struct MagnificationGestureDemo: View {

    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0

    var body: some View {
        VStack(spacing: 20) {

            // Ex. 1
            Text("Hello world")
                .font(.title)
                .padding(40)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .scaleEffect(1 + currentAmount + lastAmount)
                .gesture(
                    // Works in simulator
                    MagnificationGesture()
                        .onChanged{ value in
                            currentAmount = value - 1
                        }
                        .onEnded({ value in
                            lastAmount += currentAmount
                            currentAmount = 0
                        })
                )

            // Ex. 2
            HStack {
                Circle()
                    .frame(width: 35, height: 35)

                Text("Hello world")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)

            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged({ value in
                            currentAmount = value - 1
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        })
                )

            HStack {
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)

            Text("Insta demo")
        }
    }
}

#Preview {
    MagnificationGestureDemo()
}
