//
//  4_1_DragGesture2.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 13/09/24.
//

import SwiftUI

struct DragGestureDemo2: View {

    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.83
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0

    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()

            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0

                            }
                        })
                )

        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureDemo2()
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {

            Image(systemName: "chevron.up")
                .padding(.top)

            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)

            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)

            Text("This is demo widget of drag gesture.")

            Text("Create An Account")
                .foregroundStyle(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.clipShape(RoundedRectangle(cornerRadius: 25)))

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 30))
    }
}
