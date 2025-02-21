//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

class GFRepoItemViewController: GFItemInfoViewController {
    
    weak var delegate: GFRepoItemViewControllerDelegate!
    
    init(user: User, delegate: GFRepoItemViewControllerDelegate!) {
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
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(color: .systemPurple, title: "GitHub Profile", systemImageName: "person.fill")
    }
    
    override func actionButtonTappeed() {
        super.actionButtonTappeed()
        delegate.didTapGitHubProfile(for: user)
    }
    
}
