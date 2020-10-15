//
//  NetworkManager.swift
//  coreDataHW
//
//  Created by Field Employee on 10/12/20.
//

import UIKit

struct API_URLs {
    static let albumURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
}
typealias InformationHandler = (Result<albumModel, NetworkError>) -> ()


final class NetworkManager {
    static let shared = NetworkManager()
    
    let session: URLSession
    let decoder: JSONDecoder
    
    private init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
}

extension NetworkManager {
    func info(completion: @escaping InformationHandler) {
            manager.loadData()
            manager.albumModel.forEach({ (album) in
                albumArray.append(albumInfo.init(artistName: album.artistName!, releaseDate: album.releaseDate!, albumName: album.albumName!, imageUrlString: album.imageUrlString!, genreName: album.genreName!))
            })
        
        if albumArray.count != 0 {
        print("coreData")
        return
        }

        guard let url = URL(string: API_URLs.albumURL) else {return}
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.err(error.localizedDescription)))
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do{
                let result = try self.decoder.decode(albumModel.self, from: data)
                (print("networking"))
                completion(.success(result))
                
            }catch {
                completion(.failure(.decodeFailure))
            }
        }.resume()
        
        
    }
}
