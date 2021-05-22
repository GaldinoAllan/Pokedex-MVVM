//
//  PokemonViewCell.swift
//  MVVMPokedex
//
//  Created by allan.galdino on 09/05/21.
//

import UIKit

class PokemonViewCell: UITableViewCell {
  
  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var pokemonIdLb: UILabel!
  @IBOutlet weak var pokemonNameLabel: UILabel!
  
  func configureCell(withModel model: PokemonModel, pokemonSpriteData data: Data) {
    self.pokemonIdLb.text = "#\(model.id)"
    self.pokemonNameLabel.text = model.name
    self.imgView.image = UIImage(data: data)
  }
}
