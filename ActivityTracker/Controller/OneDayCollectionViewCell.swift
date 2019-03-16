//
//  OneDayCollectionViewCell.swift
//  ActivityTracker
//
//  Created by Nikolay on 25/02/2019.
//  Copyright © 2019 Nikolay Rybin. All rights reserved.
//

import UIKit

class OneDayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainCellStackView: UIStackView!
    @IBOutlet weak var progressStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var walkStepsNumberLabel: UILabel!
    @IBOutlet weak var aerobicStepsNumberLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var runStepsNumberLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var goalStatusStackView: UIStackView!
    
    
    private let walkProgressBar = UIProgressView(progressViewStyle: .bar)
    private let aerobicProgressBar = UIProgressView(progressViewStyle: .bar)
    private let runProgressBar = UIProgressView(progressViewStyle: .bar)

    private let bottomBorder = CALayer()
    private let topBorder = CALayer()
    private let line = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = self.setColor(r: 253, g: 253, b: 253)
    }
    
    
    func setData(input: oneDayInfo){
        
        
        let flag = !input.isGoalReached

        self.goalStatusStackView.isHidden = flag
            
        let borderWidth : CGFloat = 2.0

        let borderColor = setColor(r: 234, g: 234, b: 234).cgColor
        
        
        let bottomBorderParam = lineParam(xCoordinate: 0.0, yCoordinate: self.frame.size.height - borderWidth, width: self.frame.width, height: borderWidth, color: borderColor)
        
        addLine(line: bottomBorder, lineParam: bottomBorderParam)
        
        
        let topBorderParam = lineParam(xCoordinate: 0.0, yCoordinate: 0.0, width: self.frame.width, height: borderWidth, color: borderColor)
        
       addLine(line: topBorder, lineParam: topBorderParam)
        
        if !flag {
            
            let middlelineParam = lineParam(xCoordinate: (goalStatusStackView.superview?.frame.origin.x)!, yCoordinate: 96.0, width: self.goalStatusStackView.frame.width, height: borderWidth, color: setColor(r: 233, g: 233, b: 233).cgColor)
            
            addLine(line: line, lineParam: middlelineParam)

        }else{
            self.line.removeFromSuperlayer()
        }
        
        
        self.dateLabel.text = input.date
        self.resultLabel.text = input.stepsNumberProgress
        self.walkStepsNumberLabel.text = input.walkStepsNumber
        self.aerobicStepsNumberLabel.text = input.aerobicStepsNumber
        self.runStepsNumberLabel.text = input.runStepsNumber
//
//        self.goalReachedLabel.textColor = self.setColor(r: 105, g: 160, b: 176)
        

        let baseForProgressViews = self.progressLabel!
    
        
        let space = CGFloat(5)
        
        let commonWidth = Double(baseForProgressViews.frame.size.width - 2*space)
        
        let y = baseForProgressViews.frame.origin.y
        
        let height = baseForProgressViews.frame.size.height
        
        let walkX = baseForProgressViews.frame.origin.x
        let walkWidth = CGFloat(commonWidth*input.walkStepsPropotion)

        let aerobicX = walkX + walkWidth + space
        let aerobicWidth = CGFloat(commonWidth*input.aerobinStepsPropotion)

        let runX = aerobicX + aerobicWidth + space
        let runWidth = CGFloat(commonWidth*input.runStepsPropotion)
        
        


        let bars = [
            (walkProgressBar, progressBarParam(xCoordinate: walkX, yCoordinate: y, width: walkWidth, height: height, color: self.setColor(r: 176, g: 227, b: 243))),
            (aerobicProgressBar, progressBarParam(xCoordinate: aerobicX, yCoordinate: y, width: aerobicWidth, height: height, color: self.setColor(r: 89, g: 199, b: 230))),
            (runProgressBar, progressBarParam(xCoordinate: runX, yCoordinate: y, width: runWidth, height: height, color: self.setColor(r: 55, g: 131, b: 153)))
        ]
        
        for (bar, param) in bars{
            adjustProgressBar(progressBar: bar, param: param)
        }
        
    }
    
    private func adjustProgressBar(progressBar: UIProgressView, param: progressBarParam){

        progressBar.frame = CGRect(x: param.xCoordinate, y: param.yCoordinate,  width: param.width, height: param.height)

        progressBar.backgroundColor = .clear

        progressBar.tintColor = param.color
        
        //progressBar.progress = 0.0 // progress Views will reload each time

        self.progressStackView.addSubview(progressBar)
        
        progressBar.setProgress(1.0, animated: true)

    }
    
    private func addLine(line: CALayer, lineParam: lineParam){
        
        line.frame = CGRect(x: lineParam.xCoordinate, y: lineParam.yCoordinate, width: lineParam.width, height: lineParam.height)
        
        line.backgroundColor = lineParam.color
        
        self.layer.addSublayer(line)
        
    }
    
    private func setColor(r: Float, g: Float, b: Float) -> UIColor{
        let a = CGFloat(1.0)
        
        return UIColor( red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: a)
    }
    
}

struct progressBarParam {
    let xCoordinate: CGFloat
    let yCoordinate: CGFloat
    
    let width: CGFloat
    let height: CGFloat
    
    let color: UIColor
}

struct lineParam {
    let xCoordinate: CGFloat
    let yCoordinate: CGFloat
    
    let width: CGFloat
    let height: CGFloat
    
    let color: CGColor
}
