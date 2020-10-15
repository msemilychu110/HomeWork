//
//  ViewController.swift
//  coreDataHW
//
//  Created by Field Employee on 10/12/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var artistName = ""
    var albumName = ""
    var imageUrlString = ""
    var faveAlbum = [FavoriteAlbum]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        AlbumViewModel.fetchInformation()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        segmentControl.actionForSegment(at: 0)
        
        
        
    }
    
    @objc func loadList(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        }
    @objc func faveBtnPressed(sender: UIButton) {
        manager.makeFaveAlbum(albumName: albumName, artistName: artistName, imageUrlString: imageUrlString)
    }
    
    @IBAction func segmentcontrolTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            manager.loadFaveAlbum()
            faveAlbum = manager.fetchFavoriteAlbums()
        }
        tableView.reloadData()
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return albumArray.count
        } else {
            return faveAlbum.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentControl.selectedSegmentIndex == 0 {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        artistName = albumArray[indexPath.row].artistName
        albumName = albumArray[indexPath.row].albumName
        imageUrlString = albumArray[indexPath.row].imageUrlString
        cell.albumName.text = albumName
        cell.artistName.text = artistName
            guard let url = URL(string: imageUrlString) else {return UITableViewCell()}
        do {let data = try Data(contentsOf: url)
            DispatchQueue.main.async {
                cell.imgView.image = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
        cell.favoriteButton.addTarget(self, action: #selector(faveBtnPressed), for: .touchUpInside)
            return cell
        } else {
            guard let imageString = faveAlbum[indexPath.row].imageUrlString else { return UITableViewCell()}
            let artistName = faveAlbum[indexPath.row].artistName
            let albumName = faveAlbum[indexPath.row].albumName
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.textLabel?.text = albumName
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = artistName
            cell.detailTextLabel?.numberOfLines = 0
//            guard let url = URL(string: imageString) else {return UITableViewCell()}
//            do {let data = try Data(contentsOf: url)
//                DispatchQueue.main.async {
////                    cell.imageView?.image = UIImage(data: data)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
            return cell
            
        }
       
    }
    
    
}
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentControl.selectedSegmentIndex == 0 {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = DetailViewController.createVC(tuple: (imgURL: albumArray[indexPath.row].imageUrlString, artistName: albumArray[indexPath.row].artistName, albumName: albumArray[indexPath.row].albumName, releaseDate: albumArray[indexPath.row].releaseDate, genereName: albumArray[indexPath.row].genreName)) else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
