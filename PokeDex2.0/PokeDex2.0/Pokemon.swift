//
//  Pokemon.swift
//  PokeDex2.0
//
//  Created by Justin Carver on 9/6/16.
//  Copyright © 2016 Justin Carver. All rights reserved.
//

import Foundation

struct Pokemon {
    
    private let kName = "name"
    private let kID = "id"
    private let kAbilities = "abilities"
    private let kSprites = "sprites"
    private let kImageEndPoint = "front_default"
    
    var Name: String
    var ID: Int
    var Abilities: [String]
    var spriteEndpoint: String
    
    
    init?(dictionary: [String: AnyObject]) {
        guard let name = dictionary[kName] as? String,
            id = dictionary[kID] as? Int,
            abilities = dictionary[kAbilities] as? [[String: AnyObject]],
            spritesDictionary = dictionary[kSprites] as? [String: AnyObject],
            imageEndpoint = spritesDictionary[kImageEndPoint] as? String
            
            else { return nil }
        
        let abilityDictionary = abilities.flatMap { $0["ability"] as? [String: AnyObject] }
        self.Abilities = abilityDictionary.flatMap { $0["name"] as? String }
        self.Name = name
        self.ID = id
        self.spriteEndpoint = imageEndpoint
    }
}