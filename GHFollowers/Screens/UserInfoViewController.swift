//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/17/25.
//

import UIKit

class UserInfoViewController: GFDataLoadingViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username: String!
    weak var delegate: UserInfoViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    func getUserInfo() {
        showLoadingView()
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                configureUIElements(with: user)
            } catch {
                presentAdaptiveAlert(for: error)
            }
            
            dismissLoadingView()
        }
    }
    
    func configureUIElements(with user: User) {
        add(childVC: GFUserInfoHeaderViewController(user: user), to: headerView)
        add(childVC: GFRepoItemViewController(user: user, delegate: self), to: itemViewOne)
        add(childVC: GFFollowerItemViewController(user: user, delegate: self), to: itemViewTwo)
        dateLabel.text = "GitHub user since \(user.createdAt.monthYearFormat)"
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        let itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for (index, itemView) in itemViews.enumerated() {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
            
            // The following code below makes the UIScrollView have an intrinsic height.
            // This happens because the first and last subview is pinned to the UIScrollView's top and bottom anchor, respectively.
            if index == 0 { itemViews[index].topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true }
            if index == itemViews.count - 1 { itemViews[index].bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true }
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
}

extension UserInfoViewController: GFRepoItemViewControllerDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlert(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        
        presentSafariVC(with: url)
    }
    
}

extension UserInfoViewController: GFFollowerItemViewControllerDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers > 0 else {
            presentGFAlert(title: "No followers", message: "This user has not followers. What a shame 😞.", buttonTitle: "So sad")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
}
