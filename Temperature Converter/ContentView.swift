//
//  ContentView.swift
//  Temperature Converter App
//  Created by Anthony Candelino on 2024-06-09.
//

import SwiftUI

struct ContentView: View {
    @State private var inputtedTemp = 0.0
    @State private var inputtedTempType = "Celsius"
    @State private var calculatedTempType = "Fahrenheit"
    let tempOptions = ["Celsius", "Fahrenheit", "Kelvin"]
    
    func cToK() -> Double { inputtedTemp + 273.15 }
    func kToC() -> Double { inputtedTemp - 273.15 }
    func fToC() -> Double { (inputtedTemp - 32) * (5/9) }
    func cToF() -> Double { (inputtedTemp * 9/5) + 32 }
    func fToK() -> Double { fToC() + 273.15 }
    func kToF() -> Double { kToC() * (9/5) + 32 }
    
    func getCalculatedTemp() -> Double {
        if (inputtedTempType == "Celsius") {
            return calculatedTempType == "Fahrenheit" ? cToF() : cToK()
        } else if (inputtedTempType == "Fahrenheit") {
            return calculatedTempType == "Celsius" ? fToC() : fToK()
        } else if (inputtedTempType == "Kelvin") {
            return calculatedTempType == "Celsius" ? kToC() : kToF()
        }
        
        return 0.0
    }
    
    var calculatedTemp: Double {
        return getCalculatedTemp()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                let calculatedTempOptions = tempOptions.filter { $0 != inputtedTempType }
                Section("Inputted Temperature") {
                    HStack {
                        TextField("Input Temperature", value: $inputtedTemp, format: .number).keyboardType(.decimalPad)
                        Picker("", selection: $inputtedTempType) {
                            ForEach(tempOptions, id: \.self) {
                                Text($0).tag($0)
                            }
                        }.onChange(of: inputtedTempType) {
                            inputtedTemp = 0.0
                            calculatedTempType = calculatedTempOptions[0]
                        }
                    }
                }
                Section("Calculated Temperature") {
                    HStack(spacing: 50) {
                        Text("\(String(format: "%.2f", calculatedTemp))")
                        
                        Picker("", selection: $calculatedTempType) {
                            ForEach(calculatedTempOptions, id: \.self) {
                                Text($0).tag($0)
                            }
                        }.pickerStyle(.segmented)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
