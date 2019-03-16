//
//  TransformData.swift
//  ActivityTracker
//
//  Created by Nikolay on 11/02/2019.
//  Copyright © 2019 Nikolay Rybin. All rights reserved.
//

import Foundation

class TransformDataClass{
    
    func transfromArray(inputArray: [oneDayActivityInfo], aim: Int) ->  [oneDayInfo] {
        return inputArray.map ({transformOneday(inputDay: $0, aim: aim)})
        
    }

    private func transformOneday(inputDay: oneDayActivityInfo, aim: Int) -> oneDayInfo{
        
        let summStepsOfAllDay = inputDay.aerobic + inputDay.run + inputDay.walk
        
        let convertedDate = ConvertUnixTimeClass(unixTimeStamp: inputDay.date/1000, infoFormat: "dd.MM.yyyy").date
        
        let walkProportion = Double(inputDay.walk)/Double(summStepsOfAllDay)
        let runProportion = Double(inputDay.run)/Double(summStepsOfAllDay)
        let aerobicProportion = Double(inputDay.aerobic)/Double(summStepsOfAllDay)
        
        let isReached = summStepsOfAllDay > aim ? true : false
        
        let resultDay = oneDayInfo.init(date: convertedDate!, stepsNumberProgress: "\(String(summStepsOfAllDay)) / \(String(aim))", walkStepsNumber: String(inputDay.walk), runStepsNumber:  String(inputDay.run), aerobicStepsNumber: String(inputDay.aerobic), walkStepsPropotion: walkProportion, runStepsPropotion: runProportion, aerobinStepsPropotion: aerobicProportion, isGoalReached: isReached)
        
        return resultDay
    }
    
}
