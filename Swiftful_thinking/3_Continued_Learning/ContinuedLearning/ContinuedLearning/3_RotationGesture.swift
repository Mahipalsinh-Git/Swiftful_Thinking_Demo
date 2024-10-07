//
//  3_RotationGesture.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 13/09/24.
//

import SwiftUI

struct RotationGestureDemo: View {

    @State var setAngle: Angle = Angle(degrees: 0)

    var body: some View {
        VStack {
            Text("Hello, World!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(50)
                .background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)))
                .rotationEffect(setAngle)
                .gesture(
                    RotationGesture()
                        .onChanged({ angle in
                            setAngle = angle
                        })
                        .onEnded({ angle in
                            withAnimation(.spring()) {
                                setAngle = angle
                            }
                        })
                )
        }
    }
}

#Preview {
    RotationGestureDemo()
}
