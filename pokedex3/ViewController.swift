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
    
    // our array of Pokemon from CSV that we load into UI Collection View
    var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        
        // parse the csv and build up our array
        parsePokemonCSV()
        
    }
    
    //  a function to parse the pokemon.csv and put it into the pokemon array
    func parsePokemonCSV() {
        
        // the 'resource' is the file called pokemon.csv
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            // use the parser in CSV.swift file
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                // create a Pokemon obj with data from current CSV row
                let poke = Pokemon(name: name, pokedexId: pokeId)
                // add our new obj to the array
                pokemon.append(poke)
            }
        
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    // implement methods/funcs of the above protocols
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // the dequeue stuff allows for only a subset of the 700+ pokemons to be loaded at once
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            // create a pokemon object - default name for now, id is its position
            // in the collectionView
            let poke = pokemon[indexPath.row]
            
            // set the image and name of the cell from the passed in pokemon obj
            cell.configureCell(poke)
            
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
        
        return pokemon.count
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
















































