//
//  NetworkManager.swift
//  Pokemon
//
//  Created by 張永霖 on 2021/5/2.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getPokemonInformation(index: Int, completed: @escaping (PokemonData?, String?) -> Void) {
    
        let base = "https://pokeapi.co/api/v2/pokemon/"
        
        guard let url = URL(string: base + "\(index)") else {
            completed(nil, "Invalid url formate")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completed(nil, error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Network connection faild")
                return
            }
            
            guard let data = data else {
                completed(nil, "No data recieved")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(PokemonData.self, from: data)
                completed(pokemon, nil)
                return
            } catch {
                completed(nil, "JSON decode error")
                return
            }
            
        }
        
        task.resume()
        
    }
    
    func getPokemonList(countInOnePage: Int, completed: @escaping (PokemonList?, String?) -> Void) {
    
        let base = "https://pokeapi.co/api/v2/"
                
        guard let url = URL(string: base + "pokemon?limit=\(countInOnePage)&offset=0") else {
            completed(nil, "Invalid url formate")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completed(nil, error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Network connection faild")
                return
            }
            
            guard let data = data else {
                completed(nil, "No data recieved")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemonList = try decoder.decode(PokemonList.self, from: data)
                completed(pokemonList, nil)
                return
            } catch {
                completed(nil, "JSON decode error")
                return
            }
            
        }
        
        task.resume()
        
    }
    
    func downloadImage(from index: Int, completed: @escaping (UIImage?) -> Void) {
        
        let base = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        let urlString = base + "\(index).png"
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        
        task.resume()
    }
    
}
