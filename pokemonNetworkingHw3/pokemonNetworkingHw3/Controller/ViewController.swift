//
//  ViewController.swift
//  pokemonNetworkingHw3
//
//  Created by Field Employee on 10/2/20.
//

import UIKit
var pokemonImageArray = [String : Data]()
class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonArray = [String]()
    //    static var pokemonImageArray = [String : Data]()
    var pokemonTypeArray = [String: [type]]()
    var pokemonAbiityArray = [String: [ability]]()
    var pokemonInfoArray = [pokemonInfo]()
    var pokemonModelArray = [ String: String]()
    var pokemonMoveArray = [String : [move]]()
    let group = DispatchGroup()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self 
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        fetchImageTypeAbility()
        fetchPokemonName()
        //        group.notify(queue: DispatchQueue.main) {
        //            self.tableView.reloadData()
        //        }
        
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    func fetchImageTypeAbility() {
        NetworkManager.shared.fetchImageTypeAbility { (result, url) in
            self.group.enter()
            
            switch result {
            case.success(let poke):
                let imageURL = poke.sprites.other.officialArtwork.frontDefault
                let loadURL = URL(string: "\(imageURL)")
                let data = try? Data(contentsOf: (loadURL ?? URL(string: "poke.com"))!)
                if let data = data {
                    pokemonImageArray[url] = data
                }
                self.pokemonTypeArray[url] = poke.types
                self.pokemonAbiityArray[url] = poke.abilities
                self.pokemonMoveArray[url] = poke.moves
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            self.group.leave()
            self.group.notify(queue: DispatchQueue.main) {
                self.tableView.reloadData()
            }
        }
    }
    func fetchPokemonName() {
        
        NetworkManager.shared.fetchNameAndURL { (result) in
            switch result {
            case .success(let pokemon):
                pokemon.forEach { (poke) in
                    self.pokemonModelArray[poke.url] = poke.name
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        let cell = tableView.cellForRow(at: indexPath) as? TableViewCell
        guard let type = cell?.type.text, let name = cell?.name.text, let image = cell?.imgView.image else {return}
        let url = Array(pokemonModelArray.keys)[indexPath.row]
        guard let ability = pokemonAbiityArray[url] else {return}
        guard let move = pokemonMoveArray[url] else {return}
        if ability.count != 0 {
            var moves = ""
            move.forEach { (m) in
                moves = m.move.name   }
            guard let vc = DetailViewController.createVC(tuple: (image: image, name: name, type: type, ability: ability, moves: moves )) else {return}
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonModelArray.keys.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {return UITableViewCell() }
        
        let key = Array(pokemonModelArray.keys)[indexPath.row]
        if pokemonImageArray.keys.count >= 30 && pokemonTypeArray.keys.count >= 30 && pokemonModelArray.keys.count >= 30 {
            DispatchQueue.main.async {
                cell.imgView.image = UIImage(data: pokemonImageArray[key] ?? Data())
                cell.name.text = self.pokemonModelArray[key]
                self.pokemonTypeArray[key]?.forEach({ (type) in
                    cell.type.text = "\(type.type.name)"
                })
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let lastCellIndexPath = IndexPath(row: self.pokemonModelArray.count - 1, section: 0)
        guard indexPaths.contains(lastCellIndexPath) else { return }
        NetworkManager.currentNum += 30
        self.fetchPokemonName()
        self.fetchImageTypeAbility()
        print(pokemonModelArray.count)
        
    }
    
    
}
