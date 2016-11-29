//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Ken Porter on 2016-11-29.
//  Copyright © 2016 Ken Porter. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    //  @IBOulets  //
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    // the variabe that receives the passed in poke object
    var pokemon: Pokemon!
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        
    }

    // @IB Actions //

    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }
    
    

    
}
