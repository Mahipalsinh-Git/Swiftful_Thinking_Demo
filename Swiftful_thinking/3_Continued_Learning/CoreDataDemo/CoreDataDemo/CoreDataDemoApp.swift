//
//  CoreDataDemoApp.swift
//  CoreDataDemo
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI

@main
struct CoreDataDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
