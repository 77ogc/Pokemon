//
//  PokemonListVC.swift
//  Pokemon
//
//  Created by 張永霖 on 2021/5/2.
//

import UIKit

class PokemonListVC: UIViewController {
    
    var collectionView: UICollectionView!
    var list: PokemonList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        getList()
        configureCollectionView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.collectionView.reloadData()
        }
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Pokemon List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.reuseID)
    }

    
    func getList() {
        NetworkManager.shared.getPokemonList(countInOnePage: 151) { (list, error) in
            if let _ = error { return }
            guard let list = list else { return }
            self.list = list
        }
    }

}

extension PokemonListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.reuseID, for: indexPath) as? PokemonCell
        cell?.set(name: list?.results[indexPath.row].name ?? "error", index: indexPath.row)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = PokemonInfoVC(index: indexPath.row + 1)
        navigationController?.pushViewController(destVC, animated: true)
        navigationController?.modalPresentationStyle = .fullScreen
    }
    
    
}
