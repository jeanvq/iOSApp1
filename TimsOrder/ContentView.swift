//
//  ContentView.swift
//  TimsOrder
//
//  Main entry point of the app. Uses TabView to organize
//  the app into three tabs: My Order, Team Orders, and Timer.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Tab 1: Place your own order
            OrderView()
                .tabItem {
                    Label("My Order", systemImage: "cup.and.saucer.fill")
                }

            // Tab 2: See all team members' orders
            TeamOrdersView()
                .tabItem {
                    Label("Team", systemImage: "person.3.fill")
                }

            // Tab 3: Coffee run countdown timer
            CoffeeRunTimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
        }
        .tint(.red)
    }
}

#Preview {
    ContentView()
        .environmentObject(OrderViewModel())
}
