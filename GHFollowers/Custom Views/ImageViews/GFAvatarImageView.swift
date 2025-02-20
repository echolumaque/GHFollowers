//
//  GFAvtarImageView.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/15/25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = UIImage(resource: .avatarPlaceholder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}
