//
//  ItemInfoType.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

enum ItemInfoType {
    case repos, gists, followers, following
    
    var icon: String {
        switch self {
        case .repos: "folder"
        case .gists: "text.alignleft"
        case .followers: "heart"
        case .following: "person.2"
        }
    }
    
    var title: String {
        switch self {
        case .repos: "Public Repos"
        case .gists: "Public Gists"
        case .followers: "Followers"
        case .following: "Following"
        }
    }
}
