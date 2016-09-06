//
//  PokemonViewController.swift
//  PokeDex2.0
//
//  Created by Justin Carver on 9/6/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchterm = searchBar.text where searchBar.text != "" {
            PokemonController.getPokemon(searchterm) { (pokemon) in
                guard let pokemon = pokemon else { return }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.nameLabel.text = "Name: \(pokemon.Name.capitalizedString)"
                self.IDLabel.text = "ID: \(pokemon.ID)"
                self.AbilitiesLabel.text = "Abilities: \(pokemon.Abilities.joinWithSeparator(", ").capitalizedString)"
                
                ImageController.imageForURL(pokemon.spriteEndpoint, completion: { (image) in
                    self.PokemonImageView.image = image
                    })
                })
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var AbilitiesLabel: UILabel!
    @IBOutlet weak var PokemonImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
