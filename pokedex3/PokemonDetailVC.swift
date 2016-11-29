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
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    
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
