//
//  OrderView.swift
//  TimsOrder
//
//  Allows a team member to enter their name and build
//  their Tim Hortons order from available menu options.
//  @AppStorage remembers the person's name between launches.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var viewModel: OrderViewModel

    // Remembers the name even after closing the app
    @AppStorage("lastPersonName") private var personName: String = ""

    // Local state for current selections
    @State private var selectedDrink = "Double Double"
    @State private var selectedSize = "Medium"
    @State private var selectedFood = "None"
    @State private var notes = ""
    @State private var selectedExtras: Set<String> = []
    @State private var showConfirmation = false

    // Menu options
    let drinks = ["Double Double", "Black Coffee", "Steeped Tea",
                  "Iced Capp", "French Vanilla", "Hot Chocolate", "Latte"]
    let sizes  = ["Small", "Medium", "Large", "Extra Large"]
    let foods  = ["None", "Chocolate Chip Muffin", "Everything Bagel",
                  "Bagel with Cream Cheese", "Croissant", "Timbit Assortment (10)"]
    let extras = ["Extra sugar", "Extra cream", "Oat milk",
                  "Almond milk", "Decaf", "Extra shot"]

    var body: some View {
        NavigationStack {
            Form {
                // Who's ordering?
                Section("Your Name") {
                    TextField("Enter your name", text: $personName)
                        .autocorrectionDisabled()
                }

                // Drink selection
                Section("Drink") {
                    Picker("Select a drink", selection: $selectedDrink) {
                        ForEach(drinks, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.navigationLink)
                }

                // Size selection
                Section("Size") {
                    Picker("Select size", selection: $selectedSize) {
                        ForEach(sizes, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.segmented)
                }

                // Extras (tap to select multiple)
                Section("Extras") {
                    ForEach(extras, id: \.self) { extra in
                        Button(action: { toggleExtra(extra) }) {
                            HStack {
                                Text(extra)
                                Spacer()
                                if selectedExtras.contains(extra) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        .foregroundColor(.primary)
                    }
                }

                // Food selection
                Section("Food") {
                    Picker("Select food", selection: $selectedFood) {
                        ForEach(foods, id: \.self) { Text($0) }
                    }
                    .pickerStyle(.navigationLink)
                }

                // Special instructions
                Section("Special Instructions") {
                    TextField("e.g. No lid, toasted...", text: $notes, axis: .vertical)
                        .lineLimit(3)
                }

                // Save button
                Section {
                    Button(action: submitOrder) {
                        HStack {
                            Spacer()
                            Label("Save My Order", systemImage: "checkmark.circle.fill")
                                .font(.headline)
                            Spacer()
                        }
                    }
                    .disabled(personName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("☕ My Order")
            .alert("Order Saved!", isPresented: $showConfirmation) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("\(personName)'s order has been saved.")
            }
        }
    }

    // Toggle an extra on/off
    private func toggleExtra(_ extra: String) {
        if selectedExtras.contains(extra) {
            selectedExtras.remove(extra)
        } else {
            selectedExtras.insert(extra)
        }
    }

    // Build and save the order
    private func submitOrder() {
        let order = Order(
            personName: personName.trimmingCharacters(in: .whitespaces),
            drink: selectedDrink,
            size: selectedSize,
            extras: Array(selectedExtras),
            food: selectedFood,
            notes: notes
        )
        viewModel.saveOrder(order)
        showConfirmation = true
    }
}

#Preview {
    OrderView().environmentObject(OrderViewModel())
}
