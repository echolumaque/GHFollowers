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
    
    func getFollowers2(for username: String, page: Int) async throws(GFError) -> [Follower] {
        let constructedUrl = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        
        guard let accessToken: String = try? Configuration.value(for: "API_KEY") else { throw .unableToComplete }
        guard let endPoint = URL(string: constructedUrl) else { throw .invalidUsername }
        
        do {
            var networkRequest = URLRequest(url: endPoint)
            networkRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            let (data, response) = try await URLSession.shared.data(for: networkRequest)
           
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GFError.invalidResponse }
            
            return try data.decode(to: [Follower].self, dateDecodingStrategy: .iso8601)
        } catch {
            throw .invalidData
        }
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
        let constructedUrl = "\(baseURL)\(username)"
        baseNetworkCall(for: constructedUrl, completed: completed)
    }
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
            completed(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            cache.setObject(image, forKey: NSString(string: urlString))
            completed(image)
        }
        
        task.resume()
    }
    
    private func baseNetworkCall<Success: Codable, Failure: Error>(
        for constructedUrl: String,
        completed: @escaping (Result<Success, Failure>) -> Void
    ) {
        guard let accessToken: String = try? Configuration.value(for: "API_KEY") else {
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
                let parsedData = try data.decode(to: Success.self, dateDecodingStrategy: .iso8601)
                completed(.success(parsedData))
            } catch {
                completed(.failure(GFError.invalidData as! Failure))
            }
        }
        
        task.resume() // Starts the network call
    }
    
}
