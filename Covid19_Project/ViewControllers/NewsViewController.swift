//
//  NewsViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleLabelInCell: UILabel!
    @IBOutlet weak var authorLabelInCell: UILabel!
    
    let initialNews: [Article] = [
        Article(author: "Me", title: "Breaking News"),
        Article(author: "He", title: "Smth"),
        Article(author: "She", title: "Another one"),
        Article(author: "Me", title: "Breaking News"),
        Article(author: "He", title: "Smth"),
        Article(author: "She", title: "Another one"),
        Article(author: "Me", title: "Breaking News"),
        Article(author: "He", title: "Smth"),
        Article(author: "She", title: "Another one")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "News"
            collectionView.dataSource = self
    }
}

extension NewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return initialNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "News", for: indexPath) as! NewsCell
        cell.titleLabel.text = initialNews[indexPath.row].title
        cell.authorLabel.text = initialNews[indexPath.row].author

        cell.layer.borderWidth = 5
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
           return cell
    }
    
    
    
    
}
