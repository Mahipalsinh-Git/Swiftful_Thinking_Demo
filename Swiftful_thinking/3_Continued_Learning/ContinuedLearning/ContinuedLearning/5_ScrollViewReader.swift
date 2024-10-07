//
//  5_ScrollViewReader.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 13/09/24.
//

import SwiftUI

struct ScrollViewReaderDemo: View {

    @State var textFieldText: String = "0"
    @State var scrollToIndex: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            //            ScrollView {
            //                ForEach(0..<50) { index in
            //                    Text("Item no. \(index)")
            //                        .font(.headline)
            //                        .frame(height: 200)
            //                        .frame(maxWidth: .infinity)
            //                        .background(.white)
            //                        .clipShape(RoundedRectangle(cornerRadius: 10))
            //                        .shadow(radius: 10)
            //                        .padding()
            //                }
            //            }

            // Scrollview reader

            TextField("Enter number:", text: $textFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)

            Button("Go to \(textFieldText) index") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }

            ScrollView {
                ScrollViewReader{ proxy in
                    
//                    Button("Go to 30") {
//                        withAnimation(.spring()) {
//                            proxy.scrollTo(30, anchor: .top)
//                        }
//                    }

                    if #available(iOS 17.0, *) {
                        ForEach(0..<50) { index in
                            Text("Item no. \(index)")
                                .id(index)
                                .font(.headline)
                                .frame(height: 200)
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 10)
                                .padding()
                        }
                        .onChange(of: scrollToIndex) { oldValue, newValue in
                            withAnimation(.spring()) {
                                proxy.scrollTo(newValue, anchor: .top)
                            }
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderDemo()
}
