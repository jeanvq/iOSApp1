//
//  OrderViewModel.swift
//  TimsOrder
//
//  Manages the list of team orders.
//  ObservableObject = views automatically update when data changes.
//  Saves and loads orders using UserDefaults (built-in phone storage).
//

import Foundation
import SwiftUI
import Combine

class OrderViewModel: ObservableObject {
    // @Published means any view using this will refresh when orders changes
    @Published var orders: [Order] = []

    // The key used to save data in UserDefaults
    private let storageKey = "savedOrders"

    init() {
        loadOrders() // Load saved orders when app launches
    }

    // MARK: - Save or Update an Order
    /// If the person already has an order, update it. Otherwise add new.
    func saveOrder(_ order: Order) {
        if let index = orders.firstIndex(where: {
            $0.personName.lowercased() == order.personName.lowercased()
        }) {
            orders[index] = order  // Update existing order
        } else {
            orders.append(order)   // Add new order
        }
        persistOrders()
    }

    // MARK: - Delete an Order
    func deleteOrder(at offsets: IndexSet) {
        orders.remove(atOffsets: offsets)
        persistOrders()
    }

    // MARK: - Save to UserDefaults
    private func persistOrders() {
        if let encoded = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }

    // MARK: - Load from UserDefaults
    private func loadOrders() {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let decoded = try? JSONDecoder().decode([Order].self, from: data)
        else { return }
        orders = decoded
    }
}
