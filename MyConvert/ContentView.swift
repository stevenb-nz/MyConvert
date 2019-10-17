//
//  ContentView.swift
//  MyConvert
//
//  Created by Steven Brown on 13/10/19.
//  Copyright © 2019 Steven Brown. All rights reserved.
//

import SwiftUI

struct Prominent: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentStyle() -> some View {
        self.modifier(Prominent())
    }
}

struct ContentView: View {
    @State private var quantity = ""
    @State private var fromUnit = 0
    @State private var toUnit = 0
    
    let units = ["°C", "°F", "K"]
    
    var converted: Double {
        let fromQuantity = Double(quantity) ?? 0
        let celcius: Double
        let toQuantity: Double
        
        switch units[fromUnit] {
        case "°F":
            celcius = (fromQuantity-32)/9*5
        case "K":
            celcius = fromQuantity - 273.15
        default:
            celcius = fromQuantity
        }
        
        switch units[toUnit] {
        case "°F":
            toQuantity = celcius*9/5+32
        case "K":
            toQuantity = celcius + 273.15
        default:
            toQuantity = celcius
        }
        
        return toQuantity
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Convert", text: $quantity)
                        .prominentStyle()
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("From:")) {
                    Picker("Unit", selection: $fromUnit) {
                        ForEach(0  ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To:")) {
                    Picker("Unit", selection: $toUnit) {
                        ForEach(0  ..< units.count) {
                            Text("\(self.units[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted")) {
                    Text("\(converted, specifier: "%.2f") \(units[toUnit])")
                        .prominentStyle()
                }
            }
            .navigationBarTitle("MyConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
