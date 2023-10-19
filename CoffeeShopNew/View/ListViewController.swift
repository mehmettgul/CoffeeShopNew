//
//  ListViewController.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 20.09.2023.
//

import UIKit

class ListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, FeedCellDelegate {

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var responseTitle: String = ""
    var dataArray : [FeedData] = []
    
    var viewmodel = ListViewmodel()
    var likeviewmodel = FavoriteViewmodel()
    var cartviewmodel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listCollectionView.delegate = self
        self.listCollectionView.dataSource = self
        setCollectionView()
        loadInitialData()
        listTitle.text = responseTitle
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        let item = dataArray[indexPath.row]
        let isLiked = likeviewmodel.isLiked(data: item)
        cell.isLiked = isLiked
        cell.setCell(item: item)
        cell.delegate = self
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
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setCollectionView() {
        listCollectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "feedCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 20
        listCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func loadInitialData() {
        viewmodel.fetchData(with: responseTitle) { dataResponse in
            if dataResponse.isEmpty {
                print("Veri çekme başarısız oldu veya veri yok.")
            } else {
                self.dataArray = dataResponse
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()
                }
            }
        }
    }
    
    func didTapButtonInCell(_ cell: UICollectionViewCell) {
        guard let indexPath = listCollectionView.indexPath(for: cell) else {
            return
        }
        let selectedItem = dataArray[indexPath.row]
        likeviewmodel.toggleLike(data: selectedItem)
        listCollectionView.reloadData()
    }
    
    func didTapToCart(_ cell: UICollectionViewCell) {
        guard let indexPath = listCollectionView.indexPath(for: cell) else {
            return
        }
        let selectedItem = dataArray[indexPath.row]
        cartviewmodel.addCartIfNoExists(data: selectedItem)
    }
    
}
