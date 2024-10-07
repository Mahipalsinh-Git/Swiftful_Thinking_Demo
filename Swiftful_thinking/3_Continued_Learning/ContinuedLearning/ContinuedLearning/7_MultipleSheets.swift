//
//  7_MultipleSheets.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 16/09/24.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// Solved this issuing 3 ways
// 1 - use a binding
// 2 - use multiple .sheets
// 3 - use $item

struct MultipleSheetsDemo: View {

    @State var selectedModel: RandomModel = RandomModel(title: "Start")
    @State var showSheet: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            
            Button("Button 1") {
//                selectedModel = RandomModel(title: "One")
                showSheet.toggle()
            }

            Button("Button 2") {
//                selectedModel = RandomModel(title: "Two")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet, content: {
//             Way 1
//            NextScreen(selectedModel: $selectedModel)
        })
    }
}

struct NextScreen :View {
    
    // Way - 1
    // @Binding var selectedModel: RandomModel

    // Way - 2
    let selectedModel: RandomModel

    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsDemo()
}
