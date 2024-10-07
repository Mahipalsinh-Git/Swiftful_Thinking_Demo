//
//  4_DragGesture.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 13/09/24.
//

import SwiftUI

struct DragGestureDemo: View {

    @State var offset: CGSize = .zero
    @State var offset2: CGSize = .zero

    var body: some View {
        VStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.teal)
                .frame(width: 100, height: 100)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        })
                )

            ZStack {
                VStack {
                    Text("\(offset2.width)")
                    Spacer()
                }

                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.cyan)
                    .frame(width: 300, height: 500)
                    .offset(offset2)
                    .scaleEffect(getScaleAmount())
                    .rotationEffect(Angle(degrees: getRotationAmount()))
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.spring()) {
                                    offset2 = value.translation
                                }
                            })
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    offset2 = .zero
                                }
                            })
                    )
            }
        }
    }

    func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset2.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }

    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset2.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureDemo()
}
