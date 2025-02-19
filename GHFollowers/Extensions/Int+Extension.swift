//
//  Int+Extension.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/19/25.
//

import Foundation

extension Int {
    var formattedAsDecimal: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self))
        
        return formattedNumber ?? "N/A"
    }
}
