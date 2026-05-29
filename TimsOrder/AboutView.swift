//
//  AboutView.swift
//  TimsOrder (Origin & Ember Coffee Bar)
//
//  Shows the story and values of Origin & Ember.
//  Content mirrors the About page from the website.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // MARK: - Hero Image
                    Image("splash")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .clipped()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // MARK: - Tagline
                        Text("Where origin meets ember.")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("AccentColor"))
                        
                        // MARK: - Our Story
                        SectionBlock(
                            title: "Our Story",
                            content: "Origin & Ember started as a dream shared between two friends over countless late-night coffee conversations. Today, we're a neighborhood gathering place where exceptional coffee meets genuine human connection."
                        )
                        
                        // MARK: - Our Craft
                        SectionBlock(
                            title: "Our Craft",
                            content: "Every cup tells a story of origin. We source directly from farmers who share our passion for quality, sustainability, and community. Our in-house roasting transforms each bean's unique character into something extraordinary."
                        )
                        
                        // MARK: - Values
                        Text("Our Values")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        // Three value cards displayed in a grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ValueCard(icon: "leaf.fill", title: "Sustainability", color: .green)
                            ValueCard(icon: "heart.fill", title: "Community", color: .red)
                            ValueCard(icon: "star.fill", title: "Quality", color: Color("AccentColor"))
                            ValueCard(icon: "globe.americas.fill", title: "Ethical Sourcing", color: .blue)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 32)
                }
            }
            .navigationTitle("Our Story")
        }
    }
}

// MARK: - Reusable Section Block
// Used to display a titled paragraph of text
struct SectionBlock: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
    }
}

// MARK: - Value Card
// Small card showing an icon and label for each brand value
struct ValueCard: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

#Preview {
    AboutView()
}
