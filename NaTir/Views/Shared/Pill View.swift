//
//  Pill View.swift
//  NaTir
//
//  Created by David Bureš on 14.04.2023.
//

import Foundation
import SwiftUI

struct PillText: View
{
    @State var text: String
    @State var color: UIColor
    @State var font: Font = .callout
    
    var body: some View
    {
        Text(text)
            .font(font)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(Color(color))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
