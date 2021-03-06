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
        
        nameLabel.text = pokemon.name.capitalized
        
        // set up main image on top of detail scene
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImg.image = img
        
        pokedexLbl.text = "\(pokemon.pokedexId)"
        
        // setup images at bottom of the detail scene
        currentEvoImage.image = img
        
        
        
        pokemon.downloadPokemonDetail {
            // whatever we write here will only be executed
            // afer the network call is completd
            self.updateUI()
        }
    }

    func updateUI() {
        baseAttackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            evoLbl.text = "No Evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - Level \(pokemon.nextEvolutionLevel)"
            evoLbl.text = str
            
        }
        
        
    }
    
    
    // @IB Actions //

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}


























