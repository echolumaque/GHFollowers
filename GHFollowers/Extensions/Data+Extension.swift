//
//  Data+Extension.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

extension Data {
    
    func decode<T: Decodable>(to type: T.Type) throws -> T {
        try JSONDecoder().decode(type, from: self)
    }
    
}
