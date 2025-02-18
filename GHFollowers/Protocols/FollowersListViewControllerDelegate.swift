//
//  FollowersListViewControllerDelegate.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

protocol FollowersListViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}
