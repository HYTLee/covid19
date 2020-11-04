//
//  NewsViewController.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    var news: [News] = [
        News(title: "Title", author: "Scscsaqmt"),
        News(title: "Other", author: "Medccq")
        ]
    var newsCollection: UICollectionView!
    var cellId = "MyCell"

    let layout = UICollectionViewFlowLayout()


    override func viewDidLoad() {
        super.viewDidLoad()
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 160, height: 160)
        newsCollection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        newsCollection.dataSource = self
        newsCollection.delegate = self
        newsCollection.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        newsCollection.showsVerticalScrollIndicator = false
        newsCollection.backgroundColor = .white
        self.view.addSubview(newsCollection)
        
    }



    
}


extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! NewsCollectionViewCell
        cell.authorLabel.text = news[indexPath.row].author
        cell.titleLabel.text = news[indexPath.row].title
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        return cell
    }
    
    
}
