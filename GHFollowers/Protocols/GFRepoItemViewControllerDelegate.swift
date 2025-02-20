//
//  GFRepoItemViewControllerDelegate.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/20/25.
//

import Foundation

protocol GFRepoItemViewControllerDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}
