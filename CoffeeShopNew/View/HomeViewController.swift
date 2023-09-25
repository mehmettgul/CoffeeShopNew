//
//  ViewController.swift
//  CoffeeShopNew
//
//  Created by Mehmet Gül on 18.09.2023.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!

    var viewmodel = HomeViewmodel()
    var dataArray : [FeedData] = []
    var currentPage = 1
    var itemsPerPage = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedCollectionView.delegate = self
        self.feedCollectionView.dataSource = self
        self.setCollectionView()
        loadInitialData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else { return UICollectionViewCell() }
        let item = dataArray[indexPath.row]
        cell.setCell(item: item)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        if offsetY > contentHeight - screenHeight - 100 {
            currentPage += 1
            viewmodel.fetchNextPage(with: "drink") { newData in
                if newData.isEmpty {
                    print("Veri çekme başarısız oldu veya veri yok.")
                } else {
                    // Yeni verileri mevcut verilere ekleyin, temizlemeyin
                    self.dataArray += newData
                    var uniqueDataArray: [FeedData] = []
                    for data in self.dataArray {
                        if !uniqueDataArray.contains(where: { $0 == data }) {
                            uniqueDataArray.append(data)
                        }
                    }
                    self.dataArray = uniqueDataArray
                    print("--- DİĞER VERİLER ÇEKİLDİ --- \(self.dataArray)")
                    DispatchQueue.main.async {
                        self.feedCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    func setCollectionView() {
        feedCollectionView.register(UINib(nibName: "FeedCell", bundle: nil), forCellWithReuseIdentifier: "feedCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 20
        feedCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func loadInitialData() {
        viewmodel.fetchData(with: "drink", page: currentPage, per_page: 10) { dataResponse in
            if dataResponse.isEmpty {
                print("Veri çekme başarısız oldu veya veri yok.")
            } else {
                self.dataArray = dataResponse
                print("--- İLK VERİ ÇEKİLDİ --- \(self.dataArray)")
                DispatchQueue.main.async {
                    self.feedCollectionView.reloadData()
                }
            }
        }
    }
}

