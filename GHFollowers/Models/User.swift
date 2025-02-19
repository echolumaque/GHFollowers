//
//  User.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/14/25.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case name
        case location
        case bio
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case htmlUrl = "html_url"
        case following
        case followers
        case createdAt = "created_at"
    }
}

extension User {
    static let testUser = User(
        login: "echolumaque",
        avatarUrl: "https://avatars.githubusercontent.com/u/61021721?v=4",
        name: "Echo Lumaque",
        location: "Valenzuela City",
        bio: "Senior Software Engineer👨🏻‍💻 | Graduated with Latin Honors at Polytechnic University of the Philippines 🎓",
        publicRepos: 25,
        publicGists: 0,
        htmlUrl: "",
        following: 13,
        followers: 11,
        createdAt: .now
    )
}
