//
//  NetworkManager.swift
//  networkingHw2
//
//  Created by Field Employee on 10/2/20.
//

import UIKit

struct APIURL {
    static let lorePicsumURL = "https://picsum.photos/200/300"
}

final class NetworkManager {
    init() {}
    static let shared: NetworkManager = NetworkManager()
    let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    
}


extension NetworkManager {
   
    func fetchImage(completion: @escaping ((UIImage?, String?)) -> ()) {
        
        guard let url = URL(string: APIURL.lorePicsumURL) else {
            completion((nil, nil))
            return
        }
        self.session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                completion((nil, nil))
            }
            guard let data = data else {
                completion((nil, nil))
                return
            }
            var id: String?
            if let httpResponse = response as? HTTPURLResponse {
                id = httpResponse.value(forHTTPHeaderField: "picsum-id")
            }
            completion((UIImage(data: data), id))
            return
        }.resume()
  
    
}
}
