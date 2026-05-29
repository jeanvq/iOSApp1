//
//  ContactView.swift
//  TimsOrder (Origin & Ember Coffee Bar)
//
//  Shows location, hours, and contact information.
//  Includes a link to open the address in Apple Maps.
//

import SwiftUI
import MapKit

struct ContactView: View {
    
    // Coffee shop coordinates (Downtown location)
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 43.4516, longitude: -80.4925),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Map
                    Map(position: $cameraPosition)
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // MARK: - Address
                        InfoBlock(
                            icon: "mappin.circle.fill",
                            title: "Address",
                            detail: "247 Roasters Street, Downtown\nWaterloo, ON"
                        )
                        
                        Divider()
                        
                        // MARK: - Hours
                        InfoBlock(
                            icon: "clock.fill",
                            title: "Hours",
                            detail: "Mon–Fri: 6:30 AM – 7:00 PM\nSat–Sun: 7:00 AM – 8:00 PM"
                        )
                        
                        Divider()
                        
                        // MARK: - Email
                        InfoBlock(
                            icon: "envelope.fill",
                            title: "Email",
                            detail: "hello@originember.com"
                        )
                        
                        Divider()
                        
                        // MARK: - Coffee Classes
                        InfoBlock(
                            icon: "cup.and.saucer.fill",
                            title: "Coffee Classes",
                            detail: "Every Saturday at 10:00 AM & 2:00 PM"
                        )
                        
                        Divider()
                        
                        // MARK: - Open in Maps Button
                        Button(action: openInMaps) {
                            Label("Open in Apple Maps", systemImage: "map.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color("AccentColor"))
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 32)
                }
                .padding(.top)
            }
            .navigationTitle("Find Us")
        }
    }
    
    // MARK: - Open Apple Maps
    // Opens the coffee shop location in Apple Maps
    private func openInMaps() {
        let address = "247 Roasters Street, Waterloo, ON"
        let encoded = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string: "http://maps.apple.com/?q=\(encoded)") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Info Block
// Reusable row showing an icon, title, and detail text
struct InfoBlock: View {
    let icon: String
    let title: String
    let detail: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(Color("AccentColor"))
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(detail)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    ContactView()
}
