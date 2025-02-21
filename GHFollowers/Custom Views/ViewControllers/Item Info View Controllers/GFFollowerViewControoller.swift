//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

class GFFollowerItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFFollowerItemViewControllerDelegate!
    
    init(user: User, delegate: GFFollowerItemViewControllerDelegate!) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3.fill")
    }
    
    override func actionButtonTappeed() {
        super.actionButtonTappeed()
        delegate.didTapGetFollowers(for: user)
    }
    
}
