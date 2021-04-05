//
//  ContentView.swift
//  UnitConverter
//  Challenge Day (19) from 100 Days of SwiftUI
//
//  Created by Terry Thrasher on 2021-04-05.
//

import SwiftUI

// Borrowing the HWS extension to get single characters from strings so I can use it for the results
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

struct ContentView: View {
    @State private var selectedInput = 1
    @State private var selectedOutput = 2
    @State private var degreeAmount = ""
    
    let unitTypes = ["Kelvin", "Celsius", "Fahrenheit"]
    
    var firstLetterOfOutput: String {
        let scale = String(unitTypes[selectedOutput])
        let firstLetter = scale[0]
        
        if firstLetter == "K" {
            return "K"
        } else {
            return "°\(firstLetter)"
        }
    }
    
    var convertedToKelvin: Double {
        let startingTemperature = Double(degreeAmount) ?? 0
        
        if selectedInput == 0 {
            return startingTemperature
        } else if selectedInput == 1 { // Celsius
            return startingTemperature + 273.15
        } else { // Fahrenheit
            let subtractedThirtyTwo = startingTemperature - 32
            let multipliedByFiveNinths = subtractedThirtyTwo * 5 / 9
            let addedTwoSeventyThree = multipliedByFiveNinths + 273.15
            
            return addedTwoSeventyThree
        }
    }
    
    var resultTemperature: Double {
        if selectedOutput == 0 { // Kelvin
            return convertedToKelvin
        } else if selectedOutput == 1 { // Celsius
            return convertedToKelvin - 273.15
        } else { // Fahrenheit
            let subtractedTwoSeventyThree = convertedToKelvin - 273.15
            let multipliedByNineFifths = subtractedTwoSeventyThree * 9 / 5
            let addedThirtyTwo = multipliedByNineFifths + 32
            
            return addedThirtyTwo
        }
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Starting unit")) {
                    Picker("Starting unit", selection: $selectedInput) {
                        ForEach(0..<unitTypes.count) {
                            Text("\(unitTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Finishing unit")) {
                    Picker("Finishing unit", selection: $selectedOutput) {
                        ForEach(0..<unitTypes.count) {
                            Text("\(unitTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Temperatures")) {
                    TextField("Starting temperature", text: $degreeAmount)
                        .keyboardType(.numberPad)
                    Text("Result: \(resultTemperature, specifier: "%.2f")\(firstLetterOfOutput)")
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
