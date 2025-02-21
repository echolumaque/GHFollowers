//
//  Decoder.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/21/25.
//

import Foundation

class Decoder {
    static let shared = Decoder()

    let jsonDecoder: JSONDecoder

    private init() {
        jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
    }
}
