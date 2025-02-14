//
//  GFAvtarImageView.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/15/25.
//

import UIKit

class GFAvtarImageView: UIImageView {
    
    let placeholderImage = UIImage(resource: .avatarPlaceholder)
    
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
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
