//
//  DetailViewController.swift
//  pokemonNetworkingHw3
//
//  Created by Field Employee on 10/2/20.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonType: UILabel!
    @IBOutlet weak var pokemonAbility: UITextView!
    @IBOutlet weak var moves: UITextView!
    
    var detailData: (image: UIImage,name: String, type: String, ability: [ability], moves: String)?
    
    static func createVC(tuple: ((image: UIImage, name: String, type:String, ability: [ability], moves:String)?)) -> DetailViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "DetailViewControllerWithStoryBoardInstantiation") as? DetailViewController
        vc?.detailData = tuple
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        view.backgroundColor = .white
        guard let image = detailData?.image, let name = detailData?.name, let type = detailData?.type, let ability = detailData?.ability, let move = detailData?.moves else {return}
        self.imgView.image = image
        self.pokemonName?.text = "name:  \(name)"
        self.pokemonType?.text = "type: \(type)"
        ability.forEach { (ability) in
            self.pokemonAbility?.text = "ability: \(ability.ability.name)"
        }
        self.moves.text = "move : \(String(describing: move))"
        
    }
    
    
}
