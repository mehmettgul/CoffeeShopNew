//
//  CategoryCell.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 19.09.2023.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10 // hücrenin kenarlarının yuvarlatılması.
        self.layer.masksToBounds = true
    }

}
