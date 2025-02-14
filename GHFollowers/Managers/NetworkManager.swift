//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/14/25.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(
        for username: String,
        page: Int,
        completed: @escaping (Result<[Follower], GFError>) -> Void
    ) {
        
        let constructedUrl = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        guard let endPoint = URL(string: constructedUrl) else {
            completed(.failure(.invalidUsername))
            return
        }
    
        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
            guard error == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume() // Starts the network call
        
    }
}
