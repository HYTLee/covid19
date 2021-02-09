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
    var photoRecords: [PhotoRecord] = []
    let pendingOperations = PendingOperations()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("News", comment: "You like the result?")
        collectionView.dataSource = self
        collectionView.delegate = self
        getNewses()
        configureRefreshControl()
    }
    
    func createPhotoRecords() {
        for article in newses!.articles {
            photoRecords.append(PhotoRecord.init(name: article.title, url:URL(string: article.urlToImage ?? "https://i.picsum.photos/id/634/200/300.jpg?hmac=dHnJDi4giQORL4vMes_SpKmSA_edpLoLAu-c-jsNFh8")!))
        }
    }
    
    func startOperations(for photoRecord: PhotoRecord, at indexPath: IndexPath) {
      switch (photoRecord.state) {
      case .new:
        startDownload(for: photoRecord, at: indexPath)
      case .downloaded:
        startFiltration(for: photoRecord, at: indexPath)
      default:
        NSLog("do nothing")
      }
    }

    func startDownload(for photoRecord: PhotoRecord, at indexPath: IndexPath) {
      guard pendingOperations.downloadsInProgress[indexPath] == nil else {
        return
      }
      let downloader = ImageForNewsesDownloader(photoRecord)
      downloader.completionBlock = {
        if downloader.isCancelled {
          return
        }

        DispatchQueue.main.async {
          self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
            self.collectionView.reloadData()
        }
      }
      pendingOperations.downloadsInProgress[indexPath] = downloader
      pendingOperations.downloadQueue.addOperation(downloader)
    }
        
    func startFiltration(for photoRecord: PhotoRecord, at indexPath: IndexPath) {
      guard pendingOperations.filtrationsInProgress[indexPath] == nil else {
          return
      }
          
      let filterer = ImageFiltration(photoRecord)
      filterer.completionBlock = {
        if filterer.isCancelled {
          return
        }
        
        DispatchQueue.main.async {
          self.pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
            self.collectionView.reloadData()
        }
      }
      
      pendingOperations.filtrationsInProgress[indexPath] = filterer
      pendingOperations.filtrationQueue.addOperation(filterer)
    }
    
    func suspendAllOperations() {
      pendingOperations.downloadQueue.isSuspended = true
      pendingOperations.filtrationQueue.isSuspended = true
    }

    func resumeAllOperations() {
      pendingOperations.downloadQueue.isSuspended = false
      pendingOperations.filtrationQueue.isSuspended = false
    }

    func loadImagesForOnscreenCells() {
      
        let pathsArray = collectionView.indexPathsForVisibleItems
        var allPendingOperations = Set(pendingOperations.downloadsInProgress.keys)
        allPendingOperations.formUnion(pendingOperations.filtrationsInProgress.keys)
          
        var toBeCancelled = allPendingOperations
        let visiblePaths = Set(pathsArray)
        toBeCancelled.subtract(visiblePaths)
        
        var toBeStarted = visiblePaths
        toBeStarted.subtract(allPendingOperations)
          
        
        for indexPath in toBeCancelled {
          if let pendingDownload = pendingOperations.downloadsInProgress[indexPath] {
            pendingDownload.cancel()
          }
          pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
          if let pendingFiltration = pendingOperations.filtrationsInProgress[indexPath] {
            pendingFiltration.cancel()
          }
          pendingOperations.filtrationsInProgress.removeValue(forKey: indexPath)
        }
          
        
        for indexPath in toBeStarted {
          let recordToProcess = photoRecords[indexPath.row]
          startOperations(for: recordToProcess, at: indexPath)
        }
      
    }

    
    func getNewses()  {
        let urlSessin = URLSession(configuration: .default)
        guard let newsApiUrl = URL(string: newsApiURLString) else {return}
        let request = URLRequest(url: newsApiUrl)
        let dataTask =  urlSessin.dataTask(with: request) { [self] (data, response, error) in
        if error != nil {
            print(error ?? "Error is unknown")
            }
        
        if let data = data {
            do {
                self.newses = try JSONDecoder().decode(News.self, from: data)
                DispatchQueue.main.async { [self] in
                    self.collectionView.reloadData()
                }
                createPhotoRecords()
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
        
        dateParser.convertStringToDate(dateString: newses?.articles[indexPath.row].publishedAt ?? "2016-04-14T10:44:00+0000")
        dateParser.convertDateToTimeStringShort()
        
        if newses?.articles[indexPath.row].publishedAt != nil {
            cell.timeLabel.text = dateParser.dateString
            }
            else{
                cell.authorLabel.text = "Time is unknown"
            }
        
         
         let photoDetails = photoRecords[indexPath.row]
        
      
        cell.imageIV.image = photoDetails.image
         
         switch (photoDetails.state) {
         case .filtered:
            print("Filtered")
         case .failed:
           print("Failed to load")
         case .new, .downloaded:
            if !collectionView.isDragging && !collectionView.isDecelerating {
              startOperations(for: photoDetails, at: indexPath)
            }
         }
        return cell
    }
    


     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openNewsInSafari(indexPath.row)
    }
    
    
     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        suspendAllOperations()
    }

     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
           loadImagesForOnscreenCells()
           resumeAllOperations()
         }
    }
    
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenCells()
        resumeAllOperations()
    }
}





