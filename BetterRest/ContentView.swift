//
//  ContentView.swift
//  BetterRest
//
//  Created by Rodrigo on 05-07-24.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeupTime: Date = Date.now
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeIntake = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker("Select your hour", selection: $wakeupTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                
                Text("Desired amount of sleep?")
                    .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 3...12, step: 0.25)
                
                Text("Daily coffee intake")
                    .font(.headline)
                Stepper("\(coffeeIntake) cup(s)", value: $coffeeIntake, in: 1...20, step: 1)
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
        }
    }
    
    func calculateBedTime() {
        
    }
}

#Preview {
    ContentView()
}
