//
//  AlbumViewModel.swift
//  coreDataHW
//
//  Created by Field Employee on 10/12/20.
//

import Foundation

var albumArray = [albumInfo] ()
var manager = CoreDataViewModel()

class AlbumViewModel {
    
   static func fetchInformation() {
        NetworkManager.shared.info { (result) in
            switch result {
            case .success(let result):
                result.feed.results.forEach { (res) in
                    albumArray.append(albumInfo.init(artistName: res.artistName , releaseDate: res.releaseDate, albumName: res.name, imageUrlString: res.artworkUrl100, genreName: res.genres[0].name))
                    
                    manager.makeData(albumName: res.name, artistName: res.artistName, genreName: res.genres[0].name, releaseDate: res.releaseDate, imageUrlString: res.artworkUrl100)
                    
                }
            case .failure(let error):
                print(error)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        }
    }
    
}

