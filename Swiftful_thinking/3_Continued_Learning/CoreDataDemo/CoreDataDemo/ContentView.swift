//
//  ContentView.swift
//  CoreDataDemo
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name,
    //                                           ascending: true)],animation: .default)

    @FetchRequest(entity: FruitEntity.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)])
    var fruits: FetchedResults<FruitEntity>


    var body: some View {
        NavigationView {
            List {
                ForEach(fruits) { fruit in
                    NavigationLink {
                        Text("Item at \(fruit.name ?? "")")
                    } label: {
                        Text(fruit.name ?? "")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(.plain)
            .navigationTitle("Core Data")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")

        }
    }

    private func addItem() {
        withAnimation {
            //            let newItem = Item(context: viewContext)
            //            newItem.timestamp = Date()

            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = "Orange"

            saveFruites()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            //            offsets.map { items[$0] }.forEach(viewContext.delete)
            guard let index = offsets.first else { return }
            let fruitEntity = fruits[index]
            viewContext.delete(fruitEntity)

            saveFruites()
        }
    }

    private func saveFruites() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
