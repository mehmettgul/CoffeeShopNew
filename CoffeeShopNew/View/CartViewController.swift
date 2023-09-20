//
//  CartViewController.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 18.09.2023.
//

import UIKit

class CartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var cartCollectionView: UICollectionView!
    @IBOutlet weak var itemOfProduct: UILabel!
    @IBOutlet weak var totalPayment: UILabel!
    @IBOutlet weak var confirmCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartCollectionView.delegate = self
        cartCollectionView.dataSource = self
        confirmCartButton.layer.cornerRadius = 16
        setCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartCell", for: indexPath) as? CartCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = screenWidth - 10
        let cellHeight: CGFloat = 165
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func setCollectionView() {
        cartCollectionView.register(UINib(nibName: "CartCell", bundle: nil), forCellWithReuseIdentifier: "cartCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 20
        cartCollectionView.setCollectionViewLayout(layout, animated: true)
        cartCollectionView.reloadData()
    }
    
    @IBAction func confirmCartButtonClicked(_ sender: Any) {
        print("confirm Cart Button Clicked.")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let anotherViewController = storyboard.instantiateViewController(withIdentifier: "paymentViewController") as? PaymentViewController {
            self.navigationController?.pushViewController(anotherViewController, animated: true)
        }
    }
    
}
