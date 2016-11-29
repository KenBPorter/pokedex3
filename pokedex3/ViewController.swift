//
//  ViewController.swift
//  pokedex3
//
//  Created by Ken Porter on 2016-11-28.
//  Copyright © 2016 Ken Porter. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //  @IBOulets  //
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // our array of Pokemon from CSV that we load into UI Collection View
    var pokemon = [Pokemon]()
    
    // vars used by searchbar ( text did change ) func
    var filteredPokemon = [Pokemon]()
    var inSearchMode = false
    
    
    // the audio player provided by AVFoundation
    var musicPlayer: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        // changes the text of the "return" key on the keyboard 
        // associated with the search bar
        searchBar.returnKeyType = UIReturnKeyType.done
        
        // Show CANCEL which is not the X in the text entry field
        searchBar.showsCancelButton = true
        
        // parse the csv and build up our array
        parsePokemonCSV()
        
        // start the music!
//        initAudio()
        
    }
    
    // get the audio ready
    func initAudio() {
        
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        
    }
    
    //  a function to parse the pokemon.csv and put it into the pokemon array
    func parsePokemonCSV() {
        
        // the 'resource' is the file called pokemon.csv
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            // use the parser in CSV.swift file
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
// debug            print(rows)
            
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
    
    
    // implement methods/funcs of the above protocols //
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // the dequeue stuff allows for only a subset of the 700+ pokemons to be loaded at once
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            // create a pokemon object but not initialized.
            let poke: Pokemon!
            
            // depending upon our searchbar status.....
            if inSearchMode {
                poke = filteredPokemon[indexPath.row]
            } else {
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            
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
        var pcount: Int!
        
        if inSearchMode {
            pcount = filteredPokemon.count
        } else {
            pcount = pokemon.count
        }
        
        return pcount
    }

    // number of sections in the collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    // from UICollectionViewDelegateFlowLayout - defines the size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    // @IBAction Outlets  //
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
            
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
        
    }
    
    
    // search bar delegate methods/functions  //
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)  // hides the keyboard
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        inSearchMode = false
        collection.reloadData()
        view.endEditing(true)  // hides the keyboard
    }
    
    // whenever we make a keystroke in the search bar, this func will be called
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            // if nothing or if we deleted searchbar, revert to original state
            collection.reloadData()
            view.endEditing(true)  // hides the keyboard
        
        } else {
            inSearchMode = true
            
            // build a suggestion list for the search bar
            let lower = searchBar.text!.lowercased()
            
            // filter cvs array into filtered arrary
            filteredPokemon = pokemon.filter( {$0.name.range(of: lower) != nil} )
            collection.reloadData()
        }
        
    }
}


































