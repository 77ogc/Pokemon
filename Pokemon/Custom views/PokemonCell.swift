//
//  PokemonCell.swift
//  Pokemon
//
//  Created by 張永霖 on 2021/5/2.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    static let reuseID = "PokemonCell"
    
    var pokemonImage = UIImageView()
    var name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(name: String, index: Int) {
        self.name.text = name
        NetworkManager.shared.downloadImage(from: index + 1) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async { self.pokemonImage.image = image }
            
        }
    }
    
    func configureCell() {
        addSubview(pokemonImage)
        addSubview(name)
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textAlignment = .center
        
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pokemonImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pokemonImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            name.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 0),
            name.leadingAnchor.constraint(equalTo: pokemonImage.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: pokemonImage.trailingAnchor),
            name.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
}
