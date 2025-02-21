//
//  Data+Extension.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

extension Data {
    
    func decode<T: Decodable>(to type: T.Type) throws -> T {
        return try Decoder.shared.jsonDecoder.decode(type, from: self)
    }
    
}
