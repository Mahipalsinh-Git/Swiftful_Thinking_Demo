//
//  16_CoreData_Relationship.swift
//  ContinuedLearning
//
//  Created by Mahipal on 07/10/24.
//

import SwiftUI
import CoreData

// 3 Entities
// Business entity
// Department enity
// Employee entity

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        self.container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading data. \(error.localizedDescription)")
            }
        }
        context = container.viewContext
    }
    
    func saveData() {
        do {
            try context.save()
        } catch let error {
            print("Error: save data \(error.localizedDescription)")
        }
    }
}

class CoreDataRelationshipViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
}

struct CoreDataRelationship: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CoreDataRelationship()
}
