//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/14/25.
//

import UIKit

class FollowersListViewController: UIViewController {

    var username: String!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID) // This is like giving a collection view a hint on what the cell's type is. I think this is for optimization purposes?
        
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let followers):
                print("Followers count: \(followers.count)")
                print(followers)
                
            case .failure(let failure):
                presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: failure.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

#Preview {
    FollowersListViewController()
}
