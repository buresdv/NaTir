//
//  Station List Item.swift
//  NaTir
//
//  Created by David Bureš on 07.04.2023.
//

import SwiftUI

struct StationListItem: View {
    
    @State var station: Station
    
    @State var stationIconName: String? = nil
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 10) {
                if let stationIconName
                {
                    Image(systemName: stationIconName)
                        .foregroundColor(Color(uiColor: .systemBlue))
                }
                else
                {
                    Image(systemName: "tram.circle")
                        .foregroundColor(Color(uiColor: .tertiaryLabel))
                }
                
                Text(station.name)
                
                Spacer()
            }
            .contentShape(Rectangle()) /// This has to be there, otherwise the entire row won't be tappable
        }
        .frame(maxWidth: .infinity)
    }
}
