//
//  ViewController.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import UIKit

class ViewController: UIViewController {
  // variavel responsavel por realizar as requests
  let request = RequestPokedex()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    showPokedex()
  }
  
  func showPokedex() {
    // passando a url como nil para ele pegar a url padrao
    request.getAllPokemons(url: nil) { response in
      switch response {
        case .success(let model):
          // print do model
          print("X GET ALL POKEMONS \(model) \n")
          //Chamo a proxima função para exibir um pokemon especifico
          self.showPokemons()
          
        case .serverError(let description):
          print("Server Erro \(description)")
          
        case .noConnection(let description):
          print("No Connection \(description)")
          
        case .timeOut(let description):
          print("Time Out \(description)")
          
      }
    }
  }
  
  func showPokemons() {
    // passando id para procurar pokemon especifico
    request.getPokemon(id: 1) { response in
      switch response {
        case .success(let model):
          // print do model do pokemon
          print("Y GET POKEMON \(model) \n")
          
          //Chamo a proxima função para exibir a imagem
          self.showImagePokemon(urlImage: model.urlImage)
          
        case .serverError(let description):
          print("Server Erro \(description)")
          
        case .noConnection(let description):
          print("No Connection \(description)")
          
        case .timeOut(let description):
          print("Time Out \(description)")
          
      }
    }
  }
  
  func showImagePokemon(urlImage: String) {
    request.getImagePokemon(url: urlImage) { response in
      switch response {
        case .success(let model):
          print("Z IMAGE POKEMON \(model)")
          
        case .serverError(let description):
          print("Server Erro \(description)")
          
        case .noConnection(let description):
          print("No Connection \(description)")
          
        case .timeOut(let description):
          print("Time Out \(description)")
          
      }
    }
  }
}

