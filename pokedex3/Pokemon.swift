//
//  Pokemon.swift
//  pokedex3
//
//  Created by Ken Porter on 2016-11-28.
//  Copyright © 2016 Ken Porter. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    private var _pokemonURL: String!
    
    // the getters ** excellent data hiding and data protection pratice!! **
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }

    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }

    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId: String {
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel: String {
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    
    
    

    // initializer
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    
    func downloadPokemonDetail(completed: @escaping  DownloadComplete) {
        
        // now ready to use Alamofile to do network calls to get
        // pokemon details data
        
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                // pull the easy ones out of the dictonary dict first
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                
////////////////////////////
// solution from lecture
//                    // grab the first dict in the types array of dicts and access the name attribute
//                    if let name = types[0]["name"] {
//                        self._type = name.capitalized
//                    }
//
//                    // when there are more than one type in the types array
//                    if types.count > 1 {
//                        for x in 1..<types.count {
//
//                            if let name = types[x]["name"] {
//                                self._type! += "/\(name.capitalized)"
//                            }
//                        }
//                    }
/////////////////////////////
                
                
                // built an array of the Type dics, the cycle thru the array grabbing the
                // NAME attributes to build a string of names.  
                
                // fYI: if let x = y as? somethere where types.count > 0 is what the comma means
                if let typesArray = dict["types"] as? [Dictionary<String,String>] , typesArray.count > 0 {
                    
                    var index = 0
                    var namesList = ""
                    
                    for type in typesArray {
                        
                        if let name = type["name"] {
                            // build the string of names with a / delimiter
                            if index > 0 {
                                namesList += "/"
                            }
                            namesList += name.capitalized
                            index += 1
                        }
                    }
                    self._type = namesList
                    
                } else {
                    self._type = ""  // the if let types above failed
                }
                
                
                // Now get the descriptions which are an array of dictionaries
                // same format as the typesArray above
                if let descArray = dict["descriptions"] as? [Dictionary<String,String>] , descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        
                        // grab the url response
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                   
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescription
                                }
                            }
                         
                            // the compelete for the Alamofire.request(descURL).responseJSON
                            completed()
                        }
                    }
                } else { // the else of if let descArray = .....
                    self._description = ""
                } // end of the if let descArrary = dict....
                
                
                
                
                // Now get the evolutions which are an array of dictionaries
                // same format as the typesArray above
                if let evolutionsArray = dict["evolutions"] as? [Dictionary<String,AnyObject>] , evolutionsArray.count > 0 {
                    
                    if let nextEvolution = evolutionsArray[0]["to"] as? String {
                        
                        // need to exclude evolutions that include mega b/c they're not in our csv
                        if nextEvolution.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvolution
                            
                            // use the uri to extract ID vs calling another web requst
                            if let uri = evolutionsArray[0]["resource_uri"] as? String {
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoID = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoID
                             
                                if let lvlExist = evolutionsArray[0]["level"] {
                                    
                                    if let lvl = lvlExist as? Int {
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                    
                                } else {
                                    self._nextEvolutionLevel = ""
                                }
                            }
                        }
                    }
                    
                }
                
                
                
                
            }
            
            // the compelete for the  Alamofire.request(_pokemonURL).responseJSON
            
            // let the funciton know JSON data retrieval has completed 
            // so the UI triggers fire and update stuff (yes I'm tired 😀)
            completed()
            
        }
        
    }

}































