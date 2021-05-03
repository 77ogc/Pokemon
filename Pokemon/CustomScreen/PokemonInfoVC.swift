//
//  PokemonInfoVC.swift
//  Pokemon
//
//  Created by 張永霖 on 2021/5/2.
//

import UIKit

class PokemonInfoVC: UIViewController {

    var index: Int!
    
    var pokemonImage = UIImageView()
    var nameLabel = UILabel()
    var idLabel = UILabel()
    var heightLabel = UILabel()
    var weightLabel = UILabel()
    var typeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureAddviews()
        configureConstraints()
        getPokemonInfo()
        
    }
    
    init(index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureAddviews() {
        view.addSubview(pokemonImage)
        view.addSubview(idLabel)
        view.addSubview(nameLabel)
        view.addSubview(heightLabel)
        view.addSubview(weightLabel)
        view.addSubview(typeLabel)
        
        pokemonImage.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        heightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            pokemonImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pokemonImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pokemonImage.heightAnchor.constraint(equalToConstant: view.bounds.width - 100),
            
            nameLabel.topAnchor.constraint(equalTo: pokemonImage.bottomAnchor, constant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImage.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: pokemonImage.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
            idLabel.leadingAnchor.constraint(equalTo: pokemonImage.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: pokemonImage.trailingAnchor),
            idLabel.heightAnchor.constraint(equalToConstant: 20),
            
            heightLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 25),
            heightLabel.leadingAnchor.constraint(equalTo: pokemonImage.leadingAnchor),
            heightLabel.trailingAnchor.constraint(equalTo: pokemonImage.trailingAnchor),
            heightLabel.heightAnchor.constraint(equalToConstant: 20),
            
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 25),
            weightLabel.leadingAnchor.constraint(equalTo: pokemonImage.leadingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: pokemonImage.trailingAnchor),
            weightLabel.heightAnchor.constraint(equalToConstant: 20),
            
            typeLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 25),
            typeLabel.leadingAnchor.constraint(equalTo: pokemonImage.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: pokemonImage.trailingAnchor),
            typeLabel.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
    func getPokemonInfo() {
        NetworkManager.shared.getPokemonInformation(index: index) { [weak self] (data, error) in
            guard let self = self else { return }
            if let _ = error {
                self.setDefault()
                return
            }
            
            guard let data = data else {
                self.setDefault()
                return
            }
            
            self.setImage(index: self.index)
            self.setInfo(data: data)
            
        }
    }

    func setImage(index: Int) {
        NetworkManager.shared.downloadImage(from: index) { [weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async { self.pokemonImage.image = image }

        }
    }
    
    func setInfo(data: PokemonData) {
        
        DispatchQueue.main.async {
            self.nameLabel.text = "Name : \(data.name)"
            self.idLabel.text = "ID : \(data.id)"
            self.heightLabel.text = "Height : \(data.height)"
            self.weightLabel.text = "Weight : \(data.weight)"
            self.typeLabel.text = "Type : "
            for type in data.types {
                self.typeLabel.text! += "\(type.type.name) "
            }
        }
    }
    
    func setDefault() {
        pokemonImage.image = UIImage(named: "國動")
        nameLabel.text = "kevin"
        idLabel.text = "7414"
        heightLabel.text = "100"
        weightLabel.text = "100"
        typeLabel.text = "poison"
    }

}
