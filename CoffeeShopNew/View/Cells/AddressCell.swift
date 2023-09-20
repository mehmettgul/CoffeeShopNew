//
//  AddressCell.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 19.09.2023.
//

import UIKit

class AddressCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}
