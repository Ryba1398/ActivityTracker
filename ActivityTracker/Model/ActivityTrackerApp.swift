//
//  ActivityTrackerApp.swift
//  ActivityTracker
//
//  Created by Nikolay on 11/02/2019.
//  Copyright © 2019 Nikolay Rybin. All rights reserved.
//

import Foundation

class ActivityTrackerApp: NSObject {
    
    private var downloadedData : Data? = nil
    
    private var parsedData : [oneDayActivityInfo]? = nil
    
    private let url = "https://intern-f6251.firebaseio.com/intern/metric.json"
    
    private (set) var result : [oneDayInfo]? = nil
    
    private (set) var notificationName = "Ntf"
    
    var newAim: Int {
        set{
            let aim = newValue
            UserDefaults.standard.set(aim, forKey: "Aim")
            self.update()
        }
        get{
            return UserDefaults.standard.integer(forKey: "Aim")
        }
    }

    private func didDataUpdate(){
        NotificationCenter.default.post(
            name: Notification.Name(notificationName),
            object: self
        )
    }
    
    private func download(){
        downloadedData = DownloadDataFromApi(urlString: url).downloadedData
    }
    
    private func parse(){
        parsedData = JsonParser(inpputJson: downloadedData!, outputType: [oneDayActivityInfo].self).output
    }
    
    private func transform(){
        result = TransformDataClass().transfromArray(inputArray: parsedData!, aim: newAim)
    }
    
    func update(){
        self.transform()
        self.didDataUpdate()
    }
    
    func doThis(){
        self.download()
        self.parse()
        self.update()
    }
}




struct oneDayActivityInfo: Decodable {
    let aerobic, run, walk : Int
    let date : Double
}

struct oneDayInfo{
    let date, stepsNumberProgress, walkStepsNumber, runStepsNumber, aerobicStepsNumber : String
    let walkStepsPropotion, runStepsPropotion, aerobinStepsPropotion : Double
    let isGoalReached : Bool
    
}
