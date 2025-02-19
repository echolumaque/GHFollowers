//
//  GFEmptystateView.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/17/25.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        configureMessageLabel()
        configureLogoImageView()
    }
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.numberOfLines = 4
        messageLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -50 : -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = UIImage(resource: .emptyStateLogo)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed {
            logoImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
            logoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        }
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -50 : -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 115 : 200),
            logoImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 35 : 50),
            
        ])
    }
    
}
