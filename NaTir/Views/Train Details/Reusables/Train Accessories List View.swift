//
//  Train Accessories List View.swift
//  NaTir
//
//  Created by David Bureš on 10.04.2023.
//

import SwiftUI

struct TrainAccessoriesListView: View {
    
    @State var train: Train
    
    var body: some View {
        HStack
        {
            if train.hasFirstClass
            {
                AccessoryItem(number: 1)
            }
            AccessoryItem(number: 2)
            if train.allowsBikes
            {
                AccessoryItem(iconName: "bicycle")
            }
            if train.hasWifi
            {
                AccessoryItem(iconName: "wifi")
            }
        }
    }
}

struct AccessoryItem: View
{
    
    @State var iconName: String?
    @State var number: Int?
    
    var body: some View
    {
        if let iconName
        {
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 15, alignment: .center)
                .foregroundColor(.white)
                .background(alignment: .center) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
                }
        }
        if let number
        {
            Text(String(number))
                .scaledToFit()
                .frame(width: 15, alignment: .center)
                .foregroundColor(.white)
                .background(alignment: .center) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.blue)
                        .frame(width: 20, height: 20)
                }
        }
        
    }
}

struct AccessoryItem_Previews: PreviewProvider
{
    static var previews: some View
    {
        AccessoryItem(number: 1)
    }
}

