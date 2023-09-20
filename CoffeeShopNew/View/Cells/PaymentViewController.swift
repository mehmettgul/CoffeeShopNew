//
//  PaymentViewController.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 19.09.2023.
//

import UIKit

class PaymentViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var addressCollectionView: UICollectionView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var creditCardView: UIView!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var cardExpirationDate: UILabel!
    @IBOutlet weak var cardCVV: UILabel!
    @IBOutlet weak var cardTableView: UITableView!
    
    @IBOutlet weak var totalPayment: UILabel!
    @IBOutlet weak var confirmPaymentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressCollectionView.delegate = self
        addressCollectionView.dataSource = self
        cardTableView.delegate = self
        cardTableView.dataSource = self
        setCollectionView()
        setRadius()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addressCell", for: indexPath) as? AddressCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 15.0, bottom: 5.0, right: 15.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 100.0
        let cellHeight: CGFloat = 50
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func setCollectionView() {
        addressCollectionView.register(UINib(nibName: "AddressCell", bundle: nil), forCellWithReuseIdentifier: "addressCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        addressCollectionView.showsHorizontalScrollIndicator = false
        layout.sectionInset = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
        layout.minimumInteritemSpacing = 15
        addressCollectionView.setCollectionViewLayout(layout, animated: true)
        addressCollectionView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // kaç bölüm olacağı
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5 // her bölümde kaç satır olacağı
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "creditCardCell")!
        cell.textLabel?.text = "deneme"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("table view'daki bir satıra tıklanıldı.")
    }
    
    func setRadius() {
        addressView.layer.cornerRadius = 16
        creditCardView.layer.cornerRadius = 16
        addressCollectionView.layer.cornerRadius = 10
        cardTableView.layer.cornerRadius = 10
        addButton.layer.cornerRadius = 16
        editButton.layer.cornerRadius = 16
        deleteButton.layer.cornerRadius = 16
        confirmPaymentButton.layer.cornerRadius = 16
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
    }
    
    @IBAction func confirmPaymentButtonClicked(_ sender: Any) {
    }
}
