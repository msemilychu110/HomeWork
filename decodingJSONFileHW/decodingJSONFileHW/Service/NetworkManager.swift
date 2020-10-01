//
//  NetworkManager.swift
//  decodingJSONFileHW
//
//  Created by Field Employee on 9/30/20.
//

import Foundation

final class NetworkManager {
    
    static let shared: NetworkManager = NetworkManager()
    
    private init() {}
}

extension NetworkManager {
    func getInformation() -> Information? {
        
        guard let path = Bundle.main.path(forResource: "SampleJSONDragon", ofType: "json")
        else {return nil}
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonObjc = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            guard let baseDict = jsonObjc as? [String: Any] else {return nil}
//            print (baseDict)
            return self.parseInformation(base: baseDict)
        }catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func parseInformation(base: [String: Any]) -> Information? {
        
        guard let damageRelations = base["damage_relations"] as? [String: Any] else { return nil }
        let doubleDamageFrom = damageRelations["double_damage_from"]
        var dDamageFrom : [damageFrom] = []
        dDamageFrom.append((doubleDamageFrom) as! damageFrom)
        
        let doubleDamageTo = damageRelations["double_damage_to"]
        var dDamageTo : [nameLink] = []
        dDamageTo.append((doubleDamageTo as! nameLink))
        
        let halfDamageFrom = damageRelations["half_damage_from"]
        var hDamageFrom : [nameLink] = []
        hDamageFrom.append(halfDamageFrom as! nameLink)
        
        let halfDamageTo = damageRelations["half_damage_to"]
        var hDamageTo = [nameLink]()
        hDamageTo.append(halfDamageTo as! nameLink)
        
        let noDamageFrom = damageRelations["no_damage_from"]
        var nDamageFrom = [NSNull] ()
        nDamageFrom.append(noDamageFrom as! NSNull)
        
        let noDamageTo = damageRelations["no_damage_to"]
        var nDamageTo = [nameLink] ()
        nDamageTo.append(noDamageTo as! nameLink)
        guard let gameIndices = base["game_indices"]  else {
            return nil
        }
        var gIndices: [gameIndices] = []
        gIndices.append(gameIndices as! gameIndices)
        
        guard let generation = base["generation"] else {
            return nil
        }
        var gen = [nameLink]()
        gen.append(generation as! nameLink)
        
        guard let id = base["id"]  else {return nil}
        var idArray = [Int] ()
        idArray.append(id as! Int)
        
        guard let moveDamageClass = base["move_damage_class"] else {return nil}
        var mDamageClass = [nameLink]()
        mDamageClass.append(moveDamageClass as! nameLink)
        
        guard let moves = base["moves"] else {return nil}
        var mves = [nameLink]()
        mves.append(moves as! nameLink)
        
        guard let name = base["name"]  else {return nil}
        var nme = [String]()
        nme.append(name as! String)
        
        guard let pokemon = base["pokemon"] else {return nil}
        var pkemn: [pokemon] = []
        pkemn.append(pokemon as! pokemon)
        
        return Information(double_damage_from: dDamageFrom, double_damage_to: dDamageTo.first, half_damage_from: hDamageFrom, half_damage_to: hDamageTo.first, no_damage_from: nDamageFrom.first, no_damage_to: nDamageTo.first, game_indices: gIndices, generation: gen.first, id: idArray.first, move_damage_class: mDamageClass.first, moves: mves, name: nme.first, pokemon: pkemn)
}
    

}
