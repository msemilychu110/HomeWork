//
//  NetworkManager.swift
//  pokemonNetworkingHw3
//
//  Created by Field Employee on 10/2/20.
//

import UIKit

struct API_URLs {
    
    static let pokemonURL = "https://pokeapi.co/api/v2/pokemon?limit=30&offset="
    
    
}
typealias InformationHandler = (Result<[ nameLink], NetworkError>) -> ()
typealias PokemonInformationHandler = (Result<pokemonInfo, NetworkError>, _ url: String) -> ()


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    let session: URLSession
    let decoder: JSONDecoder
    static var currentNum: Int = 0
    private init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
}

extension NetworkManager {
    
    func fetchNameAndURL(completion: @escaping InformationHandler ) {
        var fullPath: String
        if NetworkManager.currentNum != 0  && NetworkManager.currentNum <= 500{
            fullPath = API_URLs.pokemonURL + "\(NetworkManager.currentNum)"
        } else { NetworkManager.currentNum = 0
            fullPath = API_URLs.pokemonURL + "\(NetworkManager.currentNum)"
        }
        
        guard let url = URL(string: fullPath) else {
            completion(.failure(.badURL))
            return
        }
        self.session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(.failure(err as? NetworkError ?? .err("error")))
                return
            }
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            do {
                let page = try self.decoder.decode(pokemonModel.self, from: data)
                completion(.success(page.results))
                //                print(page.results)
            } catch {
                completion(.failure(.decodeFailure))
            }
        }.resume()
    }
    
    func fetchImageTypeAbility(completion: @escaping(PokemonInformationHandler) ) {
        fetchNameAndURL { (result) in
            switch result {
            case .success(let pokemon):
                pokemon.forEach { (poke) in
                    let url = URL(string: poke.url)
                    if let url = url {
                        self.session.dataTask(with: url) { (data, response, error) in
                            if let err = error {
                                completion(.failure(err as? NetworkError ?? .err("error")), poke.url)
                                return
                            }
                            guard let data = data else {
                                completion(.failure(.badData), poke.url)
                                return
                            }
                            do {
                                let page = try self.decoder.decode(pokemonInfo.self, from: data)
                                completion(.success(page), poke.url)
                                //                print(page.results)
                            } catch {
                                completion(.failure(.decodeFailure), poke.url)
                            }
                        }.resume()
                        
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
}
