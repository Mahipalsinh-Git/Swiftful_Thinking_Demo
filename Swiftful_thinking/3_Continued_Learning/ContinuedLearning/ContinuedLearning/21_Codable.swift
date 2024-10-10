//
//  21_Codable.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/9/24.
//

import SwiftUI

struct CustomerModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    
}

struct CodableDemo: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    CodableDemo()
}
