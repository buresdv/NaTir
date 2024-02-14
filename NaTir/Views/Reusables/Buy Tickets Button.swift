//
//  Buy Tickets Button.swift
//  NaTir
//
//  Created by David Bureš on 09.04.2023.
//

import SwiftUI

struct BuyTicketsButton: View
{
    @State var price: Double
    @State var isFullWidth: Bool
    var action: () -> Void

    var body: some View
    {
        Button
        {
            action()
        } label: {
            if !isFullWidth
            {
                Label("\(String(price))€", systemImage: "cart")
            }
            else
            {
                Label("\(String(price))€", systemImage: "cart")
                    .padding(5)
                    .frame(maxWidth: .infinity)
            }
        }
        .tint(.green)
        .buttonStyle(.borderedProminent)
    }
}
