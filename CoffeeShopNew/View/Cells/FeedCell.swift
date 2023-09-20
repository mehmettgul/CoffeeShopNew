//
//  FeedCell.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 19.09.2023.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    @IBAction func addCartButtonClicked(_ sender: Any) {
        print("add cart button clicked.")
    }
    
    @IBAction func addFavoriteButtonClicked(_ sender: Any) {
        print("add favorite button clicked.")
    }
    
}
