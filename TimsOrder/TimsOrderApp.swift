//
//  TimsOrderApp.swift
//  TimsOrder
//
//  App entry point. Creates a single shared OrderViewModel
//  and injects it into the environment so all views can access it.
//

import SwiftUI

@main
struct TimsOrderApp: App {
    // Single source of truth for all orders
    @StateObject private var viewModel = OrderViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
