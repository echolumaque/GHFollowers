//
//  UserInfoViewControllerDelegate.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

protocol UserInfoViewControllerDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}
