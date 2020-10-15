//
//  CoreDataManager.swift
//  coreDataHW
//
//  Created by Field Employee on 10/13/20.
//

import Foundation
import CoreData

class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "coreDataHW")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("something went wrong")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do{
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func makeData(albumName: String, artistName: String, genreName: String,releaseDate: String, imageUrlstring: String) -> AlbumModel? {
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "AlbumModel", in: context) else {return nil}
        let albumModel = AlbumModel(entity: entity, insertInto: context)
        albumModel.albumName = albumName
        albumModel.artistName = artistName
        albumModel.genreName = genreName
        albumModel.releaseDate = releaseDate
        albumModel.imageUrlString = imageUrlstring
        return albumModel
        
    }
    
    func fetchAlbum() -> [AlbumModel]? {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<AlbumModel> = AlbumModel.fetchRequest()
        do {
            let albumModelArray = try context.fetch(request)
            print(albumModelArray)
            return albumModelArray
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    
    func makeFaveAlbum(albumName: String, artistName: String,imageUrlstring: String) -> FavoriteAlbum? {
        let context = self.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteAlbum", in: context) else {return nil}
        let albumModel = FavoriteAlbum(entity: entity, insertInto: context)
        albumModel.albumName = albumName
        albumModel.artistName = artistName
        albumModel.imageUrlString = imageUrlstring
        return albumModel
        
    }
    
    func fetchFavoriteAlbum() -> [FavoriteAlbum]? {
        let context = self.persistentContainer.viewContext
        let request: NSFetchRequest<FavoriteAlbum> = FavoriteAlbum.fetchRequest()
        do {
            let albumModelArray = try context.fetch(request)
            print(albumModelArray)
            return albumModelArray
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
