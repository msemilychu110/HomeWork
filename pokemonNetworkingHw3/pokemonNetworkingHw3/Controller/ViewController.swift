//
//  ViewController.swift
//  pokemonNetworkingHw3
//
//  Created by Field Employee on 10/2/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonModelDict = [Int: pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self 
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableView.automaticDimension
        
        fetchPokemonName()
        
    }
    
    func fetchPokemonName() {
        
        NetworkManager.shared.fetchNameAndURL { (result) in
            switch result {
            case .success(let poke):
                let ability = poke.abilities
                var abilityDescription = [String]()
                ability.forEach { (string) in
                    abilityDescription.append(string.ability.name)
                }
                
                let move = poke.moves
                var  moveDescription = [String]()
                move.forEach { (string) in
                    moveDescription.append(string.move.name)
                }
                
                self.pokemonModelDict[poke.id - 1] = pokemon.init(abilities: abilityDescription, moves: moveDescription, name: poke.name, sprites: poke.sprites, types: poke.types)
                
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
        let sortedPokemonDict = pokemonModelDict.sorted {$0.key < $1.key}
        let ability = sortedPokemonDict[indexPath.row].value.abilities
        let move = sortedPokemonDict[indexPath.row].value.moves
        guard let vc = DetailViewController.createVC(tuple: ((image: image, name: name, type: type, ability: ability, moves: move))) else {return}
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonModelDict.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {return UITableViewCell() }
        
        let sortedPokemonDict = pokemonModelDict.sorted{$0.key < $1.key}
        if sortedPokemonDict.count >= 30 {
            
            let imgURL = sortedPokemonDict[indexPath.row].value.sprites.other.officialArtwork.frontDefault
            let loadURL = URL(string: imgURL)
            let data = try? Data(contentsOf: loadURL!)
            DispatchQueue.main.async {
                if let data = data {
                    cell.imgView.image = UIImage(data: data)
                }
                cell.name.text = sortedPokemonDict[indexPath.row].value.name
                sortedPokemonDict[indexPath.row].value.types.forEach { (type) in
                    cell.type.text = type.type.name
                }
                
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
        let lastCellIndexPath = IndexPath(row: self.pokemonModelDict.count - 1, section: 0)
        guard indexPaths.contains(lastCellIndexPath) else { return }
        NetworkManager.currentNum += 30
        self.fetchPokemonName()
    }  
}
