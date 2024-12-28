//
//  ContentView.swift
//  muqoddimah_one
//
//  Created by Muhammad Arif on 21/12/24.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        // more to come
        VStack{
            ForEach(0..<rows, id: \.self){
                row in HStack{
                    ForEach(0..<columns, id: \.self){
                        col in content(row, columns)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    @State private var showingAlert = false
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    
    var totalPerPerson: Double {
        // calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    func executeDelete() {
        print("Now deleting…")
    }
    
    var body: some View {
        VStack {
            Stepper("\(sleepAmount) hours", value: $sleepAmount, in: 4...9)
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()
        }
        
    }
}

#Preview {
    ContentView()
}
