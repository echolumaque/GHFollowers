//
//  FollowerView.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/21/25.
//

import SwiftUI

struct FollowerView: View {
    
    var follower: Follower
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(.avatarPlaceholder)
                    .resizable()
                    .scaledToFit()
            }
            .clipShape(.circle)

            Text(follower.login)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.6)
        }
    }
}

#Preview {
    FollowerView(follower: Follower(login: "echolumaque", avatarUrl: ""))
}
