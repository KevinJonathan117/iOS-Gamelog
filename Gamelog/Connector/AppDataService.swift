//
//  AppDataService.swift
//  Gamelog
//
//  Created by Kevin Jonathan on 29/09/22.
//

import Foundation

protocol DataService {
    func getGames(query: String, completion: @escaping ([Game], Bool) -> Void)
    func getGameDetail(id: Int, completion: @escaping (Game?, Bool) -> Void)
}

class AppDataService: DataService {
    let baseUrl = "https://api.rawg.io/api"
    let key = "05193e403aa040e8b460c5785d3e822a"
    
    func getGames(query: String, completion: @escaping ([Game], Bool) -> Void) {
        let query = query.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(baseUrl)/games?key=\(key)&search=\(query)")
        guard let url = url else {
            completion([], true)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let games = try decoder.decode(GameList.self, from: data)
                    DispatchQueue.main.async {
                        completion(games.results ?? [], false)
                    }
                } catch(let e) {
                    print("Failed to Decode JSON \(e)")
                    completion([], true)
                }
                
            } else {
                print("Unexpected Error")
                completion([], true)
            }
        }
        task.resume()
    }
    
    func getGameDetail(id: Int, completion: @escaping (Game?, Bool) -> Void) {
        let url = URL(string: "\(baseUrl)/games/\(id)?key=\(key)")
        guard let url = url else {
            completion(nil, true)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let game = try decoder.decode(Game.self, from: data)
                    DispatchQueue.main.async {
                        completion(game, false)
                    }
                } catch(let e) {
                    print("Failed to Decode JSON \(e)")
                    completion(nil, true)
                }
                
            } else {
                print("Unexpected Error")
                completion(nil, true)
            }
        }
        task.resume()
    }
}
