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

    @Published var businesses: [BusinessEntity] = []
    @Published var departments: [DepartmentEntity] = []

    init() {
        fetchBusinesses()
    }

    func addBusiness() {
        let newBusiness = BusinessEntity(context: manager.context)
        newBusiness.name = "Apple"

        // add existing departments to the new business
//        newBusiness.departments =

        // add existing employeess to the new business
//        newBusiness.employees = []

        // add new business to existing department
//        newBusiness.addToDepartments(<#T##value: DepartmentEntity##DepartmentEntity#>)

        // add new business to existing employee
//        newBusiness.addToEmployees(<#T##value: EmployeeEntity##EmployeeEntity#>)

        save()
    }

    func addDepartment() {
        let newDepartment = DepartmentEntity(context: manager.context)
        newDepartment.name = "Marketing"
        newDepartment.businesses = [businesses[0]]
        save()
    }

    func fetchBusinesses() {
        let request = NSFetchRequest<BusinessEntity>(entityName: "BusinessEntity")

        do {
            businesses = try manager.context.fetch(request)
        } catch let error {
            print("Error: Fetching business: \(error.localizedDescription)")
        }
    }



    func save() {
        businesses.removeAll()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.manager.saveData()
            self.fetchBusinesses()
        })
    }
}

struct CoreDataRelationship: View {
    
    @StateObject var vm = CoreDataRelationshipViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Button {
//                        vm.addBusiness()
                        vm.addDepartment()
                    } label: {
                        Text("Action")
                            .foregroundStyle(.white)
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.clipShape(RoundedRectangle(cornerRadius: 10)))
                    }

                    // Business
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack (alignment: .top) {
                            ForEach(vm.businesses) { business in
                                BusinessView(entity: business)
                            }
                        }
                    }

                    // Department
                    ScrollView(.horizontal, showsIndicators: true) {
                        HStack (alignment: .top) {
                            ForEach(vm.departments) { department in
                                DepartmentView(entity: department)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Core Data Relationship")
        }
    }
}

#Preview {
    CoreDataRelationship()
}

struct BusinessView: View {

    let entity: BusinessEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "N/A")")
                .bold()

            // Departments Data
            if let departments = entity.departments?.allObjects as? [DepartmentEntity] {
                Text("Departments: ")
                    .bold()

                ForEach(departments, id: \.self) { department in
                    Text(department.name ?? "N/A")
                }
            }

            // Employee Data
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()

                ForEach(employees, id: \.self) { employee in
                    Text(employee.name ?? "N/A")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.gray.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
    }
}

struct DepartmentView: View {

    let entity: DepartmentEntity

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Name: \(entity.name ?? "N/A")")
                .bold()

            // Departments Data
            if let businesses = entity.businesses?.allObjects as? [BusinessEntity] {
                Text("Businesses: ")
                    .bold()

                ForEach(businesses, id: \.self) { business in
                    Text(business.name ?? "N/A")
                }
            }

            // Employee Data
            if let employees = entity.employees?.allObjects as? [EmployeeEntity] {
                Text("Employees: ")
                    .bold()

                ForEach(employees, id: \.self) { employee in
                    Text(employee.name ?? "N/A")
                }
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .background(Color.green.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 10)
    }
}
