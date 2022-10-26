//
//  ContentView.swift
//  UnitConverter
//
//  Created by Eric Tolson on 9/8/22.
//

import SwiftUI

struct ContentView: View {
    @State private var originalNumber = 32.0
    @State private var originalType = UnitTemperature.fahrenheit
    @State private var convertedType = UnitTemperature.celsius
    @FocusState private var amountIsFocused: Bool
    
    let temperatures: [UnitTemperature] = [.fahrenheit, .celsius, .kelvin]
    
    let formatter: MeasurementFormatter
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
    
    var tempConversion: String {
        let inputMeasurement = Measurement(value: originalNumber, unit: originalType)
        let outputMeasurement = inputMeasurement.converted(to: convertedType)
        return formatter.string(from: outputMeasurement).capitalized
    
    }
    
    var body: some View {
        NavigationView {
            
            Form {
                Section {
                    Picker("Type", selection: $originalType) {
                        ForEach(temperatures, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                            }
                        }
                    TextField("Value", value: $originalNumber, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    } header: {
                        Text("Starting Temperature")
                    }
                
                Section {
                    Picker("Type", selection: $convertedType) {
                        ForEach(temperatures, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                            }
                        }
                    Text(tempConversion)
                    } header: {
                        Text("Converted Temperature")
                }
            }
            
        .navigationTitle("Temperature Converter")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
