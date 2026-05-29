//
//  ContentView.swift
//  TimsOrder
//
//  Main navigation for Origin & Ember Coffee Bar app.
//  Uses TabView with three tabs: Menu, About, and Contact.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Tab 1: Coffee menu
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "cup.and.saucer.fill")
                }

            // Tab 2: About the coffee bar
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle.fill")
                }

            // Tab 3: Contact and location
            ContactView()
                .tabItem {
                    Label("Contact", systemImage: "mappin.and.ellipse")
                }
        }
        .tint(Color("AccentColor"))
    }
}

#Preview {
    ContentView()
}
