//
//  Array - Closest Element.swift
//  NaTir
//
//  Created by David Bureš on 08.04.2023.
//

import Foundation

extension Array where Element: Comparable & SignedNumeric
{
    func nearest(to value: Element) -> (offset: Int, element: Element)?
    {
        enumerated().min(by: {
            abs($0.element - value) < abs($1.element - value)
        })
    }
}
