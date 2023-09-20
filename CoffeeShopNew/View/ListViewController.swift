//
//  ListViewController.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 20.09.2023.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
