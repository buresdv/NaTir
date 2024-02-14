//
//  Labelled Divider.swift
//  NaTir
//
//  Created by David Bureš on 16.04.2023.
//

import Foundation
import SwiftUI

struct LabeledDivider: View
{
    let label: LocalizedStringKey
    let horizontalPadding: CGFloat
    let color: Color

    var body: some View
    {
        HStack
        {
            line
            Text(label).foregroundColor(color)
            line
        }
    }

    var line: some View
    {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}
