//
//  12_Hasable.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI

struct MyCustomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MyCustomHashableModel: Hashable {
    let title: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HasableDemo: View {

    let dataList: [MyCustomModel] = [
        MyCustomModel(title: "One"),
        MyCustomModel(title: "Two"),
        MyCustomModel(title: "Three"),
        MyCustomModel(title: "Four")
    ]

    let dataHashableList: [MyCustomHashableModel] = [
        MyCustomHashableModel(title: "One"),
        MyCustomHashableModel(title: "Two"),
        MyCustomHashableModel(title: "Three"),
        MyCustomHashableModel(title: "Four")
    ]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(dataList) { item in
                    Text(item.title)
                        .font(.headline)
                }

                Divider()

                ForEach(dataHashableList, id: \.self) { item in
                    Text(item.title)
                        .font(.headline)
                }

                //                ForEach(dataList, id: \.self) { item in
                //                    Text(item.hashValue.description)
                //                        .font(.headline)
                //                }
            }
        }
    }
}

#Preview {
    HasableDemo()
}
