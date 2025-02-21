//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/14/25.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int) async throws(GFError) -> [Follower] {
        let constructedUrl = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        let followers: [Follower] = try await baseNetworkCall(for: constructedUrl)
        
        return followers
    }
    
    func getUserInfo(for username: String) async throws(GFError) -> User {
        let constructedUrl = "\(baseURL)\(username)"
        let user: User = try await baseNetworkCall(for: constructedUrl)
        
        return user
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = cache.object(forKey: cacheKey) { return cachedImage }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
    private func baseNetworkCall<Result: Codable>(for constructedUrl: String) async throws(GFError) -> Result {
        guard let accessToken: String = try? Configuration.value(for: "API_KEY") else { throw .unableToComplete }
        guard let endPoint = URL(string: constructedUrl) else { throw .invalidUsername }
        
        do {
            var networkRequest = URLRequest(url: endPoint)
            networkRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            let (data, response) = try await URLSession.shared.data(for: networkRequest)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GFError.invalidResponse }
            
            let parsedData = try data.decode(to: Result.self)
            
            return parsedData
        } catch {
            throw .invalidData
        }
    }
    
}
