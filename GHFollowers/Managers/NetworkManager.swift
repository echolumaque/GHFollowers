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
        completed: @escaping ([Follower]?, String?) -> Void
    ) {
        
        let constructedUrl = "\(baseURL)\(username)/followers?per_page=100&page=\(page)"
        guard let endPoint = URL(string: constructedUrl) else {
            completed(nil, "This username created an invalid request. Please try again.")
            return
        }
    
        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
            guard error == nil else {
                completed(nil, "Unable to complete your request. Please check your internet connection.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again.")
                return
            }
            
            guard let data else {
                completed(nil, "The data received from the server was invalid. Please try again.")
                return
            }
            
            do {
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "The data received from the server was invalid. Please try again.")
            }
        }
        
        task.resume() // Starts the network call
        
    }
}
