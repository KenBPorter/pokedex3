//
//  ViewController.swift
//  pokedex3
//
//  Created by Ken Porter on 2016-11-28.
//  Copyright © 2016 Ken Porter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //IBOulets
    @IBOutlet weak var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        
    }
    
    // implement methods/funcs of the above protocols
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // the dequeue stuff allows for only a subset of the 700+ pokemons to be loaded at once
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            // create a pokemon object - default name for now, id is its position
            // in the collectionView
            let pokemon = Pokemon(name: "Pokemon", pokedexId: indexPath.row)
            
            // set the image and name of the cell from the passed in pokemon obj
            cell.configureCell(pokemon)
            
            return cell
            
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    // when we tap on a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // sets the number of items in the section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 30
    }

    // number of sections in the collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // from UICollectionViewDelegateFlowLayout - defines the size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    
}
















































