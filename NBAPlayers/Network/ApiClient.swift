//
//  ApiClient.swift
//  NBAPlayers
//
//  Created by Aleksandr Anosov on 10.11.2020.
//

import Foundation

enum ApiError: Error {
    case noData
}

protocol ApiClient {
    func getPlayers(onResult: @escaping (Result<[Player], Error>) -> Void)
    func getGames(onResult: @escaping (Result<[Game], Error>) -> Void)
}

class ApiClientImpl: ApiClient {
    
    let baseUrl = "https://www.balldontlie.io/api/v1"

    func getPlayers(onResult: @escaping (Result<[Player], Error>) -> Void) {

        let session = URLSession.shared

        let url = URL(string: baseUrl + "/players")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in

            guard let data = data else {
                onResult(.failure(ApiError.noData))
                return
            }

            do {
                let playersResponse = try JSONDecoder().decode(PlayersResponse.self, from: data)
                onResult(.success(playersResponse.data))
            } catch(let error) {
                print(error)
                onResult(.failure(error))
            }

        })

        dataTask.resume()
    }
    
    func getGames(onResult: @escaping (Result<[Game], Error>) -> Void) {
        let session = URLSession.shared
        
        let url = URL(string: baseUrl + "/games")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            
            guard let data = data else {
                onResult(.failure(ApiError.noData))
                return
            }
            
            do {
                let gamesResponse = try JSONDecoder().decode(GamesResponse.self, from: data)
                onResult(.success(gamesResponse.data))
            } catch(let error) {
                print(error)
                onResult(.failure(error))
            }
            
        })
        
        dataTask.resume()
    }
}
