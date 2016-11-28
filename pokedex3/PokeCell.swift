//
//  PokeCell.swift
//  pokedex3
//
//  Created by Ken Porter on 2016-11-28.
//  Copyright © 2016 Ken Porter. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    // the rounded corner code
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // each view has a layer level where you can modify how it looks
        layer.cornerRadius = 6.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
        
        
        
    }
    
    
    
}
