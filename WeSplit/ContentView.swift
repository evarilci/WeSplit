//
//  ContentView.swift
//  WeSplit
//
//  Created by Eymen Varilci on 24.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPerson = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10,15,20,25,0]
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPerson + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section ("Check amount"){
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currencyCode ?? "TRY"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPerson) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much tıp do you want to leave?"){
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Each") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "TRY"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
