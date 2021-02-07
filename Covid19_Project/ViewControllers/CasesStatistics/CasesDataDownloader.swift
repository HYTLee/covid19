//
//  CasesDataDownloader.swift
//  Covid19_Project
//
//  Created by AP Yauheni Hramiashkevich on 2/5/21.
//

import Foundation
import UIKit

class CasesDataDownloader: CaseDownloader  {
    
     var response = [Case]()
    
     func getStatisticsFromApi(completion:@escaping () -> ())  {
        let session = URLSession(configuration: .default)

        guard  let covidURL = URL(string: "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true")
        else {return}
        let urlRequest = URLRequest(url: covidURL)
       let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error{
                print(error)
        }
        
        if let data = data {
            do {
                self.response = try JSONDecoder().decode([Case].self, from: data)
                print(self.response.count)
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                print(error)
            }
        }
        }
        dataTask.resume()
    }
    
}
