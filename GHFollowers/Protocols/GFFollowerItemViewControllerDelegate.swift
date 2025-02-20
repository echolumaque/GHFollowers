//
//  GFFollowerItemViewControllerDelegate.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/20/25.
//

import Foundation

protocol GFFollowerItemViewControllerDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}
