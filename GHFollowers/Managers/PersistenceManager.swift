//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Echo Lumaque on 2/18/25.
//

import Foundation

enum PersistenceActionType { case add, remove }

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys { static let favorites = "favorites" }
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll(where: { $0.login == favorite.login })
                }
                
                completed(save(favorites: favorites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let favorites = try favoritesData.decode(to: [Follower].self)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encodedFavorites = try favorites.encode()
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
