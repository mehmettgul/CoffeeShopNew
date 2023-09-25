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
    @IBOutlet weak var labelView: UIView!
    
    var viewmodel = FeedCellViewmodel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10 // hücrenin kenarlarının yuvarlatılması.
        self.layer.masksToBounds = true
    }
    
    func setCell(item: CategoryData) {
        self.categoryName.text = item.tag
        if let url = URL(string: item.previewURL) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Hata: \(error)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let dominantColor = self?.viewmodel.findDominantColor(in: image) {
                            if ((self?.viewmodel.isDarkColor(dominantColor)) ?? false) {
                                self?.categoryName.textColor = .white
                            } else {
                                self?.categoryName.textColor = .black
                            }
                            } else {
                                print("Renk Bulunamadı")
                            }
                        self?.categoryImage.image = image
                    }
                }
            }
            task.resume()
        }
    }

}
