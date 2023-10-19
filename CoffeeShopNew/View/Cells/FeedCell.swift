//
//  FeedCell.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 19.09.2023.
//

import UIKit

protocol FeedCellDelegate: AnyObject {
    func didTapButtonInCell(_ cell: UICollectionViewCell)
    func didTapToCart(_ cell: UICollectionViewCell)
}

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var addCartButton: UIButton!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var View: UIView!
    
    weak var delegate: FeedCellDelegate?
    
    var viewmodel = FeedCellViewmodel()
    var cartviewmodel = CartViewModel()
    var allCoffees: [Likes] = []
    var numberOfSteps: Int = 0
    var convertedPrice : Double = 0.0
    var price: Double = 0.0
    var formattedPrice: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    func convertIDToPrice(_ id: Int) -> Double {
        let price = Double(id) / 10.0 // ID'yi ücrete dönüştür
        return price
    }
    
    func formatPrice(_ id: Int) -> String {
        let price: Double
        let numberOfSteps = String(id).count
        // buraya yine bak
        switch numberOfSteps {
        case 9:
            price = Double(id) / 10000000.0
        case 8:
            price = Double(id) / 1000000.0
        case 7:
            price = Double(id) / 100000.0
        case 6:
            price = Double(id) / 10000.0
        case 5:
            price = Double(id) / 1000.0
        case 4:
            price = Double(id) / 1000.0
        default:
            price = Double(id) / 100.0
        }
        
        return String(format: "%.1f", price)
    }
    
    func setCell(item: FeedData) {
        productName.text = "ÜRÜN"
        let formattedPrice = formatPrice(item.id)
        productPrice.text = String(formattedPrice)

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
                            self?.View.backgroundColor = dominantColor
                            if ((self?.viewmodel.isDarkColor(dominantColor)) ?? false) {
                                self?.productName.textColor = .white
                                self?.productPrice.textColor = .white
                                self?.addCartButton.tintColor = .white
                                self?.addFavoriteButton.tintColor = .white
                            } else {
                                self?.productName.textColor = .black
                                self?.productPrice.textColor = .black
                                self?.addCartButton.tintColor = .black
                                self?.addFavoriteButton.tintColor = .black
                            }
                            } else {
                                print("Renk Bulunamadı")
                            }
                        self?.productImage.image = image
                    }
                }
            }
            task.resume()
        }
    }
    
    func setLike(item: Likes) {
        productName.text = "ÜRÜN"
        let formattedPrice = formatPrice(Int(item.coffeeId))
        productPrice.text = String(formattedPrice)

        if let url = URL(string: item.previewURL ?? "") {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Hata: \(error)")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let dominantColor = self?.viewmodel.findDominantColor(in: image) {
                            self?.View.backgroundColor = dominantColor
                            if ((self?.viewmodel.isDarkColor(dominantColor)) ?? false) {
                                self?.productName.textColor = .white
                                self?.productPrice.textColor = .white
                                self?.addCartButton.tintColor = .white
                                self?.addFavoriteButton.tintColor = .white
                            } else {
                                self?.productName.textColor = .black
                                self?.productPrice.textColor = .black
                                self?.addCartButton.tintColor = .black
                                self?.addFavoriteButton.tintColor = .black
                            }
                            } else {
                                print("Renk Bulunamadı")
                            }
                        self?.productImage.image = image
                    }
                }
            }
            task.resume()
        }
    }

    @IBAction func addCartButtonClicked(_ sender: Any) {
        print("add cart button clicked.")
        delegate?.didTapToCart(self)
    }
    
    @IBAction func addFavoriteButtonClicked(_ sender: Any) {
        print("add Favorite Button Clicked")
        delegate?.didTapButtonInCell(self)
    }
    
    var isLiked: Bool = false {
        didSet {
            // Like yapıldığında değişecek şeyler.
            let buttonImage = isLiked ? UIImage(named: "inFavorite") : UIImage(named: "favorite")
            addFavoriteButton.setImage(buttonImage, for: .normal)
        }
    }
    
}
