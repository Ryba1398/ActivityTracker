//
//  ConvertUnixTime.swift
//  ActivityTracker
//
//  Created by Nikolay on 11/02/2019.
//  Copyright © 2019 Nikolay Rybin. All rights reserved.
//

import Foundation

class ConvertUnixTimeClass {
    
    private var unixTimeStamp : Double
    private var infoFormat : String
    private (set) var date : String? = nil
    
    init(unixTimeStamp: Double, infoFormat: String) {
        self.unixTimeStamp = unixTimeStamp
        self.infoFormat = infoFormat
        self.date = getDateInfo(format: self.infoFormat)
    }
    
    private func getDateInfo (format: String) -> String {
        let currentDate = Date(timeIntervalSince1970: unixTimeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateInfo = dateFormatter.string(from: currentDate)
        return dateInfo
    }
}
