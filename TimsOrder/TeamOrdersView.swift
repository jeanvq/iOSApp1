//
//  TeamOrdersView.swift
//  TimsOrder
//
//  Displays all saved orders from team members in a list.
//  Tap an order to see the full details.
//  Swipe left to delete an order.
//

import SwiftUI

struct TeamOrdersView: View {
    @EnvironmentObject var viewModel: OrderViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.orders.isEmpty {
                    // Shown when no orders have been saved yet
                    ContentUnavailableView(
                        "No Orders Yet",
                        systemImage: "cup.and.saucer",
                        description: Text("Add your order in the My Order tab.")
                    )
                } else {
                    List {
                        ForEach(viewModel.orders) { order in
                            NavigationLink(destination: OrderDetailView(order: order)) {
                                OrderRowView(order: order)
                            }
                        }
                        .onDelete(perform: viewModel.deleteOrder)
                    }
                }
            }
            .navigationTitle("🧾 Team Orders")
            .toolbar {
                EditButton()
            }
        }
    }
}

// MARK: - Single row in the list
struct OrderRowView: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(order.personName)
                .font(.headline)
            Text(order.summary)
                .font(.subheadline)
                .foregroundColor(.secondary)
            if order.food != "None" {
                Text("🥯 \(order.food)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Full order detail screen
struct OrderDetailView: View {
    let order: Order

    var body: some View {
        List {
            Section("Person") {
                Label(order.personName, systemImage: "person.fill")
            }
            Section("Drink") {
                Label("\(order.size) \(order.drink)", systemImage: "cup.and.saucer.fill")
            }
            if !order.extras.isEmpty {
                Section("Extras") {
                    ForEach(order.extras, id: \.self) { extra in
                        Label(extra, systemImage: "plus.circle")
                    }
                }
            }
            if order.food != "None" {
                Section("Food") {
                    Label(order.food, systemImage: "fork.knife")
                }
            }
            if !order.notes.isEmpty {
                Section("Notes") {
                    Text(order.notes).italic()
                }
            }
            Section("Order Time") {
                Label(order.timestamp.formatted(date: .abbreviated, time: .shortened),
                      systemImage: "clock")
            }
        }
        .navigationTitle("\(order.personName)'s Order")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    TeamOrdersView().environmentObject(OrderViewModel())
}
