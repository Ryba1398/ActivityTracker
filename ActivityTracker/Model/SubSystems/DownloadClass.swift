//
//  DownloadClass.swift
//  ActivityTracker
//
//  Created by Nikolay on 11/02/2019.
//  Copyright © 2019 Nikolay Rybin. All rights reserved.
//

import Foundation

class DownloadDataFromApi {
    
    private (set) var downloadedData : Data? = nil
    
    private let urlString : String
    
    init(urlString: String) {
        self.urlString = urlString
        self.downloadedData = downloadData()
    }
    
    private func downloadData() -> Data{

        var downloadedData : Data? = nil
        
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        makeUrlRequest(with: urlString) { (result) in
            downloadedData = result
             myGroup.leave()
        }
        myGroup.wait()
        
        return downloadedData!
    }
    
    private func makeUrlRequest(with urlString: String,and getResult: @escaping (Data) ->()){
        
        let url = URL(string:urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil, data != nil else{
                print(error!.localizedDescription)
                return
            }
            getResult(data!)
        }
        task.resume()
    }
}
