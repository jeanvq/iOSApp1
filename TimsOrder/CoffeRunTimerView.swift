//
//  CoffeeRunTimerView.swift
//  TimsOrder
//
//  A countdown timer for the coffee run.
//  The person going to Tim Hortons sets how long they'll be gone.
//  Uses Timer.publish() which fires every second — same concept as HIITFit.
//

import SwiftUI
import Combine

struct CoffeeRunTimerView: View {
    // Saves the default duration even after closing the app
    @AppStorage("defaultRunMinutes") private var defaultMinutes: Int = 15

    @State private var secondsRemaining: Int = 0
    @State private var isRunning = false
    @State private var runnerName = ""

    // Timer that fires every 1 second on the main thread
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // Format seconds as MM:SS (e.g. 14:35)
    var timeString: String {
        let minutes = secondsRemaining / 60
        let seconds = secondsRemaining % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Progress from 0.0 to 1.0 for the ring animation
    var progress: Double {
        let total = defaultMinutes * 60
        guard total > 0 else { return 0 }
        return Double(total - secondsRemaining) / Double(total)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {

                // Name of the person doing the run
                TextField("Who's going? (name)", text: $runnerName)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)

                // Circular countdown ring
                ZStack {
                    // Background circle (grey)
                    Circle()
                        .stroke(Color.secondary.opacity(0.2), lineWidth: 16)

                    // Foreground circle (red, fills as time passes)
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(Color.red,
                                style: StrokeStyle(lineWidth: 16, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.linear(duration: 1), value: progress)

                    // Time display in the center
                    VStack(spacing: 4) {
                        Text(timeString)
                            .font(.system(size: 52, weight: .bold, design: .monospaced))
                        Text(isRunning
                             ? (runnerName.isEmpty ? "On the way!" : "\(runnerName) is on the way!")
                             : "Set your timer")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                }
                .frame(width: 240, height: 240)
                .padding()

                // Duration picker (only visible when timer is not running)
                if !isRunning {
                    Stepper("Estimated time: \(defaultMinutes) min",
                            value: $defaultMinutes, in: 5...60, step: 5)
                        .padding(.horizontal, 40)
                }

                // Start / Cancel button
                Button(action: toggleTimer) {
                    Text(isRunning ? "Cancel Run" : "Start Coffee Run ☕")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isRunning ? Color.gray : Color.red)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }

                Spacer()
            }
            .padding(.top, 24)
            .navigationTitle("⏱ Coffee Run Timer")
            // This runs every second when the timer is active
            .onReceive(timer) { _ in
                guard isRunning else { return }
                if secondsRemaining > 0 {
                    secondsRemaining -= 1
                } else {
                    isRunning = false // Timer finished!
                }
            }
        }
    }

    // Start or cancel the timer
    private func toggleTimer() {
        if isRunning {
            isRunning = false
            secondsRemaining = 0
        } else {
            secondsRemaining = defaultMinutes * 60
            isRunning = true
        }
    }
}

#Preview {
    CoffeeRunTimerView()
}
