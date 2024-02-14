//
//  Ticket Display View.swift
//  NaTir
//
//  Created by David Bureš on 11.04.2023.
//

import SwiftUI

struct TicketDisplayView: View
{
    @Binding var ticket: Ticket
    
    @State private var originalScreenBrightness: CGFloat = 1.0

    var body: some View
    {
        VStack(alignment: .center, spacing: 0)
        {
            Image(uiImage: UIImage(data: generateTicketCode(ticket: ticket)!)!)
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)

            Text(ticket.dateSaved.convertToCompleteDate())
        }
        .onAppear
        {
            originalScreenBrightness = UIScreen.main.brightness
            UIScreen.main.brightness = CGFloat(1.0)
        }
        .onDisappear
        {
            UIScreen.main.brightness = originalScreenBrightness
        }
    }

    func generateTicketCode(ticket: Ticket) -> Data?
    {
        guard let imageFilter = CIFilter(name: "CIAztecCodeGenerator") else { return nil }

        let ticketContentsAsData = ticket.contents.data(using: .utf8, allowLossyConversion: false)

        imageFilter.setValue(ticketContentsAsData, forKey: "inputMessage")

        guard let image = imageFilter.outputImage else { return nil }

        let transform = CGAffineTransform(scaleX: 10, y: 10)
        let scaledImage = image.transformed(by: transform)

        let finalImage = UIImage(ciImage: scaledImage)

        return finalImage.pngData()
    }
}
