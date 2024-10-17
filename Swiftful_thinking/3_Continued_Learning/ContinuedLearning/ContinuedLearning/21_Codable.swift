//
//  21_Codable.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/9/24.
//

import SwiftUI

// Codable = Decodable + Encodable

//struct CustomerModel: Identifiable, Decodable, Encodable { // Manually
struct CustomerModel: Identifiable, Codable { // Using codable

    let id: String
    let name: String
    let points: Int
    let isPremium: Bool

    // when use decodable and encodable
    /*
     enum CodingKeys: String, CodingKey {
     case id
     case name
     case points
     case isPremium
     }

     init(id: String, name: String, points: Int, isPremium: Bool) {
     self.id = id
     self.name = name
     self.points = points
     self.isPremium = isPremium
     }

     init(from decoder: any Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     self.id = try container.decode(String.self, forKey: .id)
     self.name = try container.decode(String.self, forKey: .name)
     self.points = try container.decode(Int.self, forKey: .points)
     self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
     }

     func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)
     try container.encode(id, forKey: .id)
     try container.encode(name, forKey: .name)
     try container.encode(points, forKey: .points)
     try container.encode(isPremium, forKey: .isPremium)
     }
     */
}

class CodableViewModel: ObservableObject {

    @Published var customer: CustomerModel?

    init () {
        getData()
    }

    func getData() {
        guard let data = getJsonData() else { return }

        // Way - 1
        //        if
        //            let localData = try? JSONSerialization.jsonObject(with: data),
        //            let dict = localData as? [String: Any],
        //            let id = dict["id"] as? String,
        //            let name = dict["name"] as? String,
        //            let points = dict["points"] as? Int,
        //            let isPremium = dict["isPremium"] as? Bool {
        //
        //            customer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
        //        }

        // Way - 2
        do {
            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
        } catch let error {
            print("Error in Decoding: \(error.localizedDescription)")
        }
    }

    func getJsonData() -> Data? {

        /*
         Manually convert
         let dict: [String: Any] = [
         "id" : "12345",
         "name" : "Mahipal",
         "points" : 100,
         "isPremium" : true
         ]

         let jsonData = try? JSONSerialization.data(
         withJSONObject: dict,
         options: .prettyPrinted
         )
         */

        let customer = CustomerModel(id: "10", name: "Hello", points: 20, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)
        
        return jsonData;
    }
}

struct CodableDemo: View {

    @StateObject var vm = CodableViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let customerObj = vm.customer {
                Text(customerObj.id)
                Text(customerObj.name)
                Text("\(customerObj.points)")
                Text("\(customerObj.isPremium)")
            }
        }
    }
}

#Preview {
    CodableDemo()
}
