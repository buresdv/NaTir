//
//  View - Conditional Modifiers.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import Foundation
import SwiftUI

extension View
{
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View
    {
        if condition
        {
            transform(self)
        }
        else
        {
            self
        }
    }
}
