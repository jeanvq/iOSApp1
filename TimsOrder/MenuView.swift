//
//  MenuView.swift
//  TimsOrder (Origin & Ember Coffee Bar)
//
//  Displays the coffee menu loaded from a local JSON file.
//  Each item shows an image, name, description, price, and
//  a Stepper to select quantity before adding to order.
//

import SwiftUI

// MARK: - Menu Item Model
// Represents a single item on the menu
struct MenuItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var description: String
    var price: Double
    var imageName: String  // Must match an asset in Assets.xcassets
    var category: String   // e.g. "Featured Roasts", "Cold Drinks"
}

// MARK: - Menu View
struct MenuView: View {
    // Load menu items from JSON on init
    @State private var menuItems: [MenuItem] = MenuDataService.loadMenu()
    
    // Track quantity per item (keyed by item id)
    @State private var quantities: [UUID: Int] = [:]
    
    // Show confirmation alert when order is placed
    @State private var showOrderConfirmation = false

    // Group items by category for section display
    var groupedItems: [String: [MenuItem]] {
        Dictionary(grouping: menuItems, by: { $0.category })
    }
    
    // Sorted category names for consistent display order
    var sortedCategories: [String] {
        groupedItems.keys.sorted()
    }
    
    // Calculate total price of current selections
    var totalPrice: Double {
        quantities.compactMap { (id, qty) in
            menuItems.first(where: { $0.id == id }).map { $0.price * Double(qty) }
        }.reduce(0, +)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    
                    // MARK: - Header Banner
                    ZStack {
                        Color(red: 0.11, green: 0.06, blue: 0.03)
                        VStack(spacing: 4) {
                            Image("splash")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 160)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    // MARK: - Menu Sections
                    VStack(alignment: .leading, spacing: 24) {
                        ForEach(sortedCategories, id: \.self) { category in
                            VStack(alignment: .leading, spacing: 12) {
                                // Category header
                                Text(category)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("AccentColor"))
                                    .padding(.horizontal)
                                
                                // Items in this category
                                ForEach(groupedItems[category] ?? []) { item in
                                    MenuItemCard(
                                        item: item,
                                        quantity: Binding(
                                            get: { quantities[item.id] ?? 0 },
                                            set: { quantities[item.id] = $0 }
                                        )
                                    )
                                }
                            }
                        }
                    }
                    .padding(.top, 24)
                    
                    // MARK: - Order Summary + Place Order Button
                    if totalPrice > 0 {
                        VStack(spacing: 12) {
                            Divider()
                            HStack {
                                Text("Total")
                                    .font(.headline)
                                Spacer()
                                Text(String(format: "$%.2f", totalPrice))
                                    .font(.headline)
                                    .foregroundColor(Color("AccentColor"))
                            }
                            .padding(.horizontal)
                            
                            Button(action: { showOrderConfirmation = true }) {
                                Text("Place Order")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color("AccentColor"))
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Our Menu")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Order Placed!", isPresented: $showOrderConfirmation) {
                Button("OK", role: .cancel) {
                    // Reset all quantities after order
                    quantities = [:]
                }
            } message: {
                Text("Your order has been placed. See you soon! ☕")
            }
        }
    }
}

// MARK: - Menu Item Card
// Individual card showing item details and stepper
struct MenuItemCard: View {
    let item: MenuItem
    @Binding var quantity: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Item image
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .clipped()
                .onAppear { print("Loading image: \(item.imageName)") }
            
            VStack(alignment: .leading, spacing: 8) {
                // Name and price
                HStack {
                    Text(item.name)
                        .font(.headline)
                    Spacer()
                    Text(String(format: "$%.2f", item.price))
                        .font(.subheadline)
                        .foregroundColor(Color("AccentColor"))
                }
                
                // Description
                Text(item.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                // Stepper for quantity
                HStack {
                    Text("Quantity:")
                        .font(.subheadline)
                    Stepper("\(quantity)", value: $quantity, in: 0...10)
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}

#Preview {
    MenuView()
}
