//
//  FavoriteViewController.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 18.09.2023.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    var fetchFavorite = FetchFavoritesViewmodel()
    var favoriteviewmodel = FavoriteViewmodel()
    var like : Likes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchFavorite.countData(entityName: "Coffee")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        like = fetchFavorite.fetchLikes()[indexPath.item]
        cell.addFavoriteButton.isHidden = true
        cell.setLike(item: like!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 20.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 60) / 2
        let cellHeight: CGFloat = 210
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func setCollectionView() {
        favoriteCollectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "feedCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 20
        favoriteCollectionView.setCollectionViewLayout(layout, animated: true)
        favoriteCollectionView.reloadData()
    }
    
}
