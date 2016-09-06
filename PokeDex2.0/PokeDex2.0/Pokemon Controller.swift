//
//  Pokemon Controller.swift
//  PokeDex2.0
//
//  Created by Justin Carver on 9/6/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation

class PokemonController {
    
    static let baseURL = "http://pokeapi.co/api/v2/pokemon/"
    
    static func getPokemon(name: String, completion: (pokemon: Pokemon?) -> Void) {
        
        let endURL = NSURL(string: baseURL + "\(name.lowercaseString)")
        
        guard let url = endURL else { completion(pokemon: nil); return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            if error != nil {
                print(error)
                completion(pokemon: nil)
                return
            }
            
            guard let data = data, JSONdictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject] else { completion(pokemon: nil); return }
            
            let pokemon = Pokemon(dictionary: JSONdictionary)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(pokemon: pokemon)
            })
        }
    }
}