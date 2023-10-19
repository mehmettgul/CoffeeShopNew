//
//  CategoryViewController.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 18.09.2023.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var viewmodel = CategoryViewmodel()
    let categories = ["drink", "hot drink", "iced drink", "coffee", "tea"]
    var categoryArray: [CategoryData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        viewmodel.fetchData(with: categories) { categoryData in
            self.categoryArray = categoryData
        }
        setCollectionView()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.setCell(item: categoryArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 20.0, bottom: 5.0, right: 20.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth - 40
        let cellHeight: CGFloat = (9 * (screenWidth - 40)) / 16
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let anotherViewController = storyboard.instantiateViewController(withIdentifier: "listViewController") as? ListViewController {
            anotherViewController.responseTitle = categoryArray[indexPath.row].tag
            self.navigationController?.pushViewController(anotherViewController, animated: true)
        }
    }
    
    func setCollectionView() {
        categoryCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 20
        categoryCollectionView.setCollectionViewLayout(layout, animated: true)
        categoryCollectionView.allowsSelection = true // tıklama özelliğinin etkinleştirilmesi.
        categoryCollectionView.reloadData()
    }
    
}
