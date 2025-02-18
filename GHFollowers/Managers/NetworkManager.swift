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
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let constructedUrl = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        baseNetworkCall(for: constructedUrl, completed: completed)
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let constructedUrl = "\(baseURL)\(username)"
        baseNetworkCall(for: constructedUrl, completed: completed)
    }
    
    private func baseNetworkCall<Success: Codable, Failure: Error>(for constructedUrl: String, completed: @escaping (Result<Success, Failure>) -> Void) {
        guard let accessToken = ProcessInfo.processInfo.environment["access_token"] else {
            completed(.failure(GFError.unableToComplete as! Failure))
            return
        }
        
        guard let endPoint = URL(string: constructedUrl) else {
            completed(.failure(GFError.invalidUsername as! Failure))
            return
        }
        
        var networkRequest = URLRequest(url: endPoint)
        networkRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    
        let task = URLSession.shared.dataTask(with: networkRequest) { data, response, error in
            guard error == nil else {
                completed(.failure(GFError.unableToComplete as! Failure))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(GFError.invalidResponse as! Failure))
                return
            }
            
            guard let data else {
                completed(.failure(GFError.invalidData as! Failure))
                return
            }
            
            do {
                let parsedData = try data.decode(to: Success.self)
                completed(.success(parsedData))
            } catch {
                completed(.failure(GFError.invalidData as! Failure))
            }
        }
        
        task.resume() // Starts the network call
    }
    
}
