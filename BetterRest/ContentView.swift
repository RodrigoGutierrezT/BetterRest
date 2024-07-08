//
//  ContentView.swift
//  BetterRest
//
//  Created by Rodrigo on 05-07-24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeupTime: Date = defaultWakeTime
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeIntake = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var idealBedtime: String {
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
                let hour = (components.hour ?? 0) * 60 * 60
                let minute = (components.minute ?? 0) * 60
                
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeIntake))
                
                let sleepTime = wakeupTime - prediction.actualSleep
                
                return sleepTime.formatted(date: .omitted, time: .shortened)
            } catch {
                return "Error"
            }
        }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Select your hour", selection: $wakeupTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Desired amount of sleep?")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 3...12, step: 0.25)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Daily coffee intake")
                            .font(.headline)
                        Stepper("^[\(coffeeIntake) cup](inflect: true)", value: $coffeeIntake, in: 1...20, step: 1)
                    }
                    
                    Section(header: Text("Your ideal bedtime is")) {
                                        Text("\(idealBedtime)")
                                            .font(.headline)
                                    }
                }
                .navigationTitle("BetterRest")
            }
        }
    }
}

#Preview {
    ContentView()
}
