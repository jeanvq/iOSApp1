//
//  Order.swift
//  TimsOrder
//
//  Data model for a single person's Tim Hortons order.
//  Codable = can be saved/loaded as JSON
//  Identifiable = can be used in Lists
//

import Foundation

struct Order: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var personName: String
    var drink: String
    var size: String
    var extras: [String]
    var food: String
    var notes: String
    var timestamp: Date = Date()

    // Short summary shown in the list (e.g. "Large Double Double")
    var summary: String {
        "\(size) \(drink)"
    }
}

// MARK: - Sample data for previews
extension Order {
    static var sampleOrders: [Order] {
        [
            Order(personName: "Jean", drink: "Double Double", size: "Large",
                  extras: ["Extra sugar"], food: "Chocolate Chip Muffin", notes: ""),
            Order(personName: "Maria", drink: "Steeped Tea", size: "Medium",
                  extras: ["Oat milk"], food: "Everything Bagel", notes: "Toasted please"),
            Order(personName: "Ahmed", drink: "Black Coffee", size: "Small",
                  extras: [], food: "None", notes: "")
        ]
    }
}
