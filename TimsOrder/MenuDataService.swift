
//
//  MenuDataService.swift
//  TimsOrder (Origin & Ember Coffee Bar)
//
//  Loads menu items from a local JSON file (menu.json).
//  Using JSON satisfies the "Swift Data/JSON" requirement.
//

import Foundation

struct MenuDataService {
    
    // MARK: - Load Menu from JSON
    /// Reads menu.json from the app bundle and decodes it into MenuItem array
    static func loadMenu() -> [MenuItem] {
        // Find the JSON file in the app bundle
        guard let url = Bundle.main.url(forResource: "menu", withExtension: "geojson") else {
            print("menu.json not found in bundle")
            return sampleMenu  // Fallback to hardcoded data
        }
        
        // Try to decode the JSON
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([MenuItem].self, from: data)
        } catch {
            print("Error decoding menu.json: \(error)")
            return sampleMenu  // Fallback to hardcoded data
        }
    }
    
    // MARK: - Sample Menu (fallback if JSON fails)
    static var sampleMenu: [MenuItem] {
        [
            MenuItem(name: "Ember Blend",
                     description: "Signature medium roast with notes of dark chocolate, caramel, and a hint of smokiness. Perfect for espresso or drip.",
                     price: 4.50,
                     imageName: "brew",
                     category: "Featured Roasts"),
            
            MenuItem(name: "Origin Guatemala",
                     description: "Single-origin from Huehuetenango region. Bright acidity, wine-like body, with citrus and floral undertones.",
                     price: 5.25,
                     imageName: "guatemala",
                     category: "Featured Roasts"),
            
            MenuItem(name: "Cold Brew Reserve",
                     description: "Specially selected beans cold-brewed for 18 hours. Smooth, naturally sweet, with notes of vanilla and nuts.",
                     price: 5.75,
                     imageName: "coldbrew",
                     category: "Cold Drinks")
        ]
    }
}
