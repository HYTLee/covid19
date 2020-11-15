//
//  NewsViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit
import SafariServices


class NewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabelInCell: UILabel!
    @IBOutlet weak var authorLabelInCell: UILabel!
   

    
    var newsApiURLString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=a05c63a1c38c497babb576e49676a0d1&category=health"
    var newses: News?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "News"
        collectionView.dataSource = self
        getNewses()
    }
    
    func getNewses()  {
        let urlSessin = URLSession(configuration: .default)
        guard let newsApiUrl = URL(string: newsApiURLString) else {return}
        let request = URLRequest(url: newsApiUrl)
       let dataTask =  urlSessin.dataTask(with: request) { (data, response, error) in
        if error != nil {
                print(error)
            }
        
        if let data = data {
            do {
                self.newses = try JSONDecoder().decode(News.self, from: data)
                print(self.newses?.articles.count)
                DispatchQueue.main.async { [self] in
                    self.collectionView.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
        }
        dataTask.resume()
    }
    
    func openNewsInSafari(_ which: Int) {
        if let url = URL(string: newses?.articles[which].url ?? "https://www.raywenderlich.com/5293-operation-and-operationqueue-tutorial-in-swift") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newses?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "News", for: indexPath) as! NewsCell
        cell.titleLabel.text = newses?.articles[indexPath.row].title
        cell.authorLabel.text = newses?.articles[indexPath.row].author
        
        guard let imageURL = URL(string:newses?.articles[indexPath.row].urlToImage ?? "http://www.raywenderlich.com/downloads/ClassicPhotosDictionary.plist"  ),
          let imageData = try? Data(contentsOf: imageURL) else {
            return cell
        }

        //1
        let unfilteredImage = UIImage(data:imageData)
        //2
        cell.backgroundColor = UIColor(patternImage: (unfilteredImage ?? UIImage(named: "DefaultCellBackground"))!)
        
        cell.layer.borderWidth = 5
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at:indexPath) as! UICollectionViewCell
        print("Print")
    }
}
