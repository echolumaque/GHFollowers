//
//  Encodable+Extension.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

extension Encodable {
    func encode() throws -> Data {
        try JSONEncoder().encode(self)
    }
}
