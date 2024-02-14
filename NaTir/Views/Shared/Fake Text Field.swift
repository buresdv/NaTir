//
//  Fake Text Field.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import SwiftUI

struct FakeTextField: UIViewRepresentable {
    @State var placeholder: LocalizedStringKey
    @Binding var station: Station
    
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.placeholder = NSLocalizedString("connections.station-search-field.placeholder", comment: "")
        textField.borderStyle = .roundedRect
        textField.isUserInteractionEnabled = false
        textField.delegate = context.coordinator
        
        return textField
    }
    
    func updateUIView(_ textField: UITextField, context: Context) {
        textField.text = station.name
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(station: $station)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var station: Station
        init(station: Binding<Station>) {
            self._station = station
        }
    }
}
