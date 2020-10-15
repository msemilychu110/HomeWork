//
//  DetailViewController.swift
//  coreDataHW
//
//  Created by Field Employee on 10/12/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    
    var detailData: (imgURL: String, artistName: String, albumName: String, releaseDate: String,genereName: String)?
    
    static func createVC(tuple:(imgURL: String, artistName: String, albumName: String, releaseDate: String,genereName: String)) -> DetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailViewControllerWithStoryBoardInstantiation") as? DetailViewController
        vc?.detailData = tuple
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imgURL = detailData?.imgURL else {return}
        guard let url = URL(string: imgURL) else {return}
        do {let data = try Data(contentsOf: url)
            DispatchQueue.main.async {
                self.imgView.image = UIImage(data: data)
            }
        } catch {
            print(error.localizedDescription)
        }
        albumName.text = detailData?.albumName
        artistName.text = detailData?.artistName
        genre.text = detailData?.genereName
        releaseDate.text = detailData?.releaseDate
    }
    

    @IBAction func faveTapped(_ sender: UIButton) {
        guard let albmName = detailData?.albumName else {return}
        guard let artName = detailData?.artistName else { return}
        guard let imgString = detailData?.imgURL else {return}
        manager.makeFaveAlbum(albumName: albmName, artistName: artName, imageUrlString: imgString)
    }
    
}
