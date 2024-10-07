//
//  13_HigherOrderFunction.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {

    @Published var dataArray: [UserModel] = []
    @Published var filterArray: [UserModel] = []
    @Published var mappedArray: [String] = []

    init() {
        getUsers()
        //        sortedArray()
        //        filteredArray()
        //        mapArray()
        allToGether()
    }

    func getUsers() {
        let user1 = UserModel(name: "first", points: 5, isVerified: true)
        let user2 = UserModel(name: "second", points: 15, isVerified: true)
        let user3 = UserModel(name: nil, points: 5, isVerified: false)
        let user4 = UserModel(name: "fourth", points: 0, isVerified: true)
        let user5 = UserModel(name: "fifth", points:12, isVerified: true)
        let user6 = UserModel(name: "sixth", points: 8, isVerified: false)
        let user7 = UserModel(name: nil, points: 9, isVerified: true)
        let user8 = UserModel(name: "eight", points: 7, isVerified: false)
        let user9 = UserModel(name: "ninth", points: 100, isVerified: true)
        let user10 = UserModel(name: "ten", points: 55, isVerified: false)

        self.dataArray.append(contentsOf: [user1,user2,user3,user4,user5,user6,user7,user8,user9,user10])
    }

    func sortedArray() {
        // Sort

        // Way - 1
        //        filterArray = dataArray.sorted(by: { user1, user2 in
        //            return user1.points < user2.points
        //        })

        // Way - 2
        filterArray = dataArray.sorted(by: {$0.points > $1.points})
    }

    func filteredArray() {
        // Sort

        // Way - 1
        //        filterArray = dataArray.filter({ userModel in
        //            return userModel.isVerified
        //        })

        // Way - 2
        filterArray = dataArray.filter({$0.isVerified})
    }

    func mapArray() {
        // Sort

        // Way - 1
        //        mappedArray = dataArray.map({ (userModel) -> String in
        //            return "\(userModel.name)"
        //        })


        // Way - 2
        //        mappedArray = dataArray.map({$0.name})

        // Compact map
        mappedArray = dataArray.compactMap({$0.name})
    }

    func allToGether() {
        mappedArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({$0.isVerified})
            .compactMap({$0.name})


    }
}

struct HigherOrderFunctionDemo: View {

    @StateObject var vm = ArrayModificationViewModel() // vm = viewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                /*
                 ForEach(vm.filterArray) { user in
                 VStack(alignment: .leading) {
                 Text(user.name)
                 .font(.headline)

                 HStack {
                 Text("Points \(user.points)")
                 Spacer()
                 if (user.isVerified) {
                 Image(systemName: "flame.fill")
                 }
                 }
                 }
                 .foregroundStyle(.white)
                 .padding()
                 .background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)))
                 .padding(.horizontal)
                 }
                 */

                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                }
            }
        }
    }
}

#Preview {
    HigherOrderFunctionDemo()
}
