//
//  Follower.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/14/25.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
    }
}
