//
//  15_CoreDataMVVM.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []

    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading datav \(error.localizedDescription)")
            }
        }
        self.fetchFruits()
    }

    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching: \(error.localizedDescription)")
        }
    }

    func addFruit(name: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name

        saveData()
    }

    func updateFruit(fruit: FruitEntity) {
        let currentName = fruit.name ?? ""
        let newName = currentName + "!"
        fruit.name = newName

        saveData()
    }

    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)

        saveData()
    }

    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("Error saved: \(error.localizedDescription)")
        }
    }
}

struct CoreDataMVVM: View {

    @StateObject var vm = CoreDataViewModel()
    @State var textFieldText: String = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Add Fruit", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)

                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(name: textFieldText)
                    textFieldText = ""
                } label: {
                    Text("Add")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                }
                .padding(.horizontal)

                List {
                    ForEach(vm.savedEntities) { fruit in
                        Text(fruit.name ?? "N/A")
                            .onTapGesture {
                                vm.updateFruit(fruit: fruit)
                            }
                    }
                    .onDelete { indexSet in
                        vm.deleteFruit(indexSet: indexSet)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Core Data")
        }
    }
}

#Preview {
    CoreDataMVVM()
}
