//
//  GFAvtarImageView.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/15/25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
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
    
    func downloadImage(from urlString: String) {
        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return }
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data else { return }
            guard let image = UIImage(data: data) else { return }
            
            cache.setObject(image, forKey: NSString(string: urlString))
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
    
}
