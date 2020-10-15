//
//  CoreDataViewModel.swift
//  coreDataHW
//
//  Created by Field Employee on 10/13/20.
//

import Foundation



class CoreDataViewModel {
    var manager: CoreDataManager
    var albumModel: [AlbumModel] = []
    var faveAlbums: [FavoriteAlbum] = []
    init(manager: CoreDataManager = CoreDataManager()) {
        self.manager = manager
    }

}
extension CoreDataViewModel {
    func makeData(albumName: String, artistName: String, genreName: String, releaseDate: String, imageUrlString: String) {
        self.albumModel.append(self.manager.makeData(albumName: albumName, artistName: artistName, genreName: genreName, releaseDate: releaseDate, imageUrlstring: imageUrlString)!)
        self.manager.saveContext()
    }
    func loadData() {
        guard let albumModel = self.manager.fetchAlbum() else {return}
        self.albumModel = albumModel
    }
    
    func makeFaveAlbum(albumName: String, artistName: String,imageUrlString: String) {
        self.faveAlbums.append(self.manager.makeFaveAlbum(albumName: albumName, artistName: artistName, imageUrlstring: imageUrlString) ?? FavoriteAlbum())
        self.manager.saveContext()
    }
    
    func loadFaveAlbum() {
        guard let faveAlbum = self.manager.fetchFavoriteAlbum() else {return }
        self.faveAlbums = faveAlbum
    }
    func fetchFavoriteAlbums() -> [FavoriteAlbum] {
        return faveAlbums
    }
}
