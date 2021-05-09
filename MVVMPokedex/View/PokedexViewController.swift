//
//  PokedexViewController.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import UIKit

class PokedexViewController: UITableViewController {
  // variável responsável pelos requests
  var requestPokedex = RequestPokedex()
  
  // gardando todos os pokemons
  var resultModel: PokedexModel?
  
  // guardando a quantidade deresultados que serao exibidos
  var resultCount = 0
  
  // guardando as informações de cada pokemon separadamente
  var pokemons = [PokemonModel]()
  
  // gaurdando as imagens de cada pokemon separadamente
  var imagePokemons = [Data]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  fileprivate func loadPokedex(url: String?) {
    // passando a url como nil para ele pegar a url padrao
    requestPokedex.getAllPokemons(url: nil) { response in
      switch response {
        case .success(let model):
          // passa o model geral para nossa variavel
          self.resultModel = model
          
          // os ids dos pokemons comecam em 1
          self.loadPokemon(self.resultCount+1)
          
          // incrementando  a quantidade de resultados que serão exibidos
          self.resultCount += model.results
          
        case .serverError(let description):
          print("Server Erro \(description)")
          
        case .noConnection(let description):
          print("No Connection \(description)")
          
        case .timeOut(let description):
          print("Time Out \(description)")
          
      }
    }
  }
  
  fileprivate func loadPokemon(_ id: Int) {
    // passando id para procurar pokemon especifico
    requestPokedex.getPokemon(id: id) { response in
      switch response {
        case .success(let model):
          // adiciona o pokemon na variavel
          self.pokemons.append(model)
          
          // manda fazer o load da imagem do pokemon carregado
          self.loadImagePokemon(url: model.urlImage)
          
        case .serverError(let description):
          print("Server Erro \(description)")
          
        case .noConnection(let description):
          print("No Connection \(description)")
          
        case .timeOut(let description):
          print("Time Out \(description)")
          
      }
    }
  }
  
  fileprivate func loadImagePokemon(url: String) {
    requestPokedex.getImagePokemon(url: url) { response in
      switch response {
        case .success(let model):
          // Salva a imagem em nossa variavel
          self.imagePokemons.append(model)

          // se o ultimo pokemon carregado ainda nao for o ultimo pokemon da lista de todos pokemons que nos temos, mandamos ele carregar o proximo pokemon
          // se já tiver sido carregado todos os pokemons eu mando atualizar a tabela
          self.pokemons.last!.id < self.resultCount ?
            self.loadPokemon(self.pokemons.last!.id + 1) :
            self.tableView.reloadData()
          
        case .serverError(let description):
          print("Server Erro \(description)")
          
        case .noConnection(let description):
          print("No Connection \(description)")
          
        case .timeOut(let description):
          print("Time Out \(description)")
          
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // se tiver proxima pafina sera adicionado a quantidade de resultados mais uma celula que irá carregar mais pokemons
    return resultModel?.next == "" ? resultCount : resultCount + 1
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == resultCount {
      loadPokedex(url: resultModel?.next)
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // se for a ultima celula, carrega o load
    if indexPath.row == resultCount {
      guard let cellLoad = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath) as? LoadViewCell else {
        return tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
      }
      
      // inicio a animacao de load
      cellLoad.loadActivity.startAnimating()
      return cellLoad
    }
    
    // se tiver tudo ok, carrega a celula pokemon
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PokemonViewCell else {
      return tableView .dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
    }
    
    // configurando o visual da celula
    cell.configureCell(withModel: pokemons[indexPath.row], pokemonSpriteData: imagePokemons[indexPath.row])
    
    return cell
  }
}
