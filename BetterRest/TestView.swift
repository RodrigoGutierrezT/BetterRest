//
//  TestView.swift
//  BetterRest
//
//  Created by Rodrigo on 07-07-24.
//

import SwiftUI

struct TestView: View {
    @State private var sleepAmount: Double = 8.0
    @State private var wakeupTime: Date = Date.now
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours",value: $sleepAmount, in: 3...12, step: 0.25)
        
        DatePicker("Please select a Date",selection: $wakeupTime, in: Date.now..., displayedComponents: .date)
            .labelsHidden()
        
        Text(Date.now, format: .dateTime.day().month().year())
        
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
    
    func examleDates() {
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

#Preview {
    TestView()
}
