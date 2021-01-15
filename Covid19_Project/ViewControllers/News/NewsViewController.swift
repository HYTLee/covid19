//
//  NewsViewController.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 10/30/20.
//

import UIKit
import SafariServices


class NewsViewController: UIViewController {
    
    let dateParser = DateParser()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabelInCell: UILabel!
    @IBOutlet weak var authorLabelInCell: UILabel!
    
   
    
    var newsApiURLString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=a05c63a1c38c497babb576e49676a0d1&category=health"
    var newses: News?
    
    private let operationQueueController = OperationQueueController()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("News", comment: "You like the result?")
        collectionView.dataSource = self
        collectionView.delegate = self
        getNewses()
        configureRefreshControl()
    }
    
    func getNewses()  {
        let urlSessin = URLSession(configuration: .default)
        guard let newsApiUrl = URL(string: newsApiURLString) else {return}
        let request = URLRequest(url: newsApiUrl)
       let dataTask =  urlSessin.dataTask(with: request) { (data, response, error) in
        if error != nil {
            print(error ?? "Error is unknown")
            }
        
        if let data = data {
            do {
                self.newses = try JSONDecoder().decode(News.self, from: data)
                print(self.newses?.articles.count ?? "Number of articless is 0")
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
    
 
    
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       collectionView.refreshControl = UIRefreshControl()
       collectionView.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        getNewses()
        DispatchQueue.main.async {
          self.collectionView.refreshControl?.endRefreshing()
       }
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
        
        if newses?.articles[indexPath.row].title != nil{
            cell.titleLabel.text = newses?.articles[indexPath.row].title
        }
        else{
            cell.titleLabel.text = "Title is unknown"
        }
        
        if newses?.articles[indexPath.row].author != nil {
        cell.authorLabel.text = newses?.articles[indexPath.row].author
        }
        else{
            cell.authorLabel.text = "Author is unknown"
        }
        
        // get time from api and put it in cell label
        dateParser.convertStringToDate(dateString: newses?.articles[indexPath.row].publishedAt ?? "2016-04-14T10:44:00+0000")
        dateParser.convertDateToTimeStringShort()
        
        if newses?.articles[indexPath.row].publishedAt != nil {
            cell.timeLabel.text = dateParser.dateString
            }
            else{
                cell.authorLabel.text = "Time is unknown"
            }
        
      
            if let url = URL(string: newses?.articles[indexPath.row].urlToImage ??  "https://i.picsum.photos/id/634/200/300.jpg?hmac=dHnJDi4giQORL4vMes_SpKmSA_edpLoLAu-c-jsNFh8"){
                operationQueueController.queue.addOperation {
                    cell.imageIV.setImageToImageView(url: url)
                }
        }
        return cell
    }
    


     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openNewsInSafari(indexPath.row)
    }
    
    
     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        operationQueueController.stopTask()
    }

     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
      if !decelerate {
        operationQueueController.continueTask()
      }
    }
    
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        operationQueueController.continueTask()
    }

    
}




