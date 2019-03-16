//
//  CommonCollectionViewController.swift
//  ActivityTracker
//
//  Created by Nikolay on 25/02/2019.
//  Copyright © 2019 Nikolay Rybin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CommonCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var activeApp = ActivityTrackerApp()
    
    private var dataArray = [oneDayInfo]()
   
    
    @IBAction func addAim(_ sender: UIBarButtonItem) {
        self.addAim()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.showsHorizontalScrollIndicator = false
        
        let notificationName = activeApp.notificationName
        
        NotificationCenter.default.addObserver( //  начиня с ios 9 не нужно вручную "выключать" обозревателя
            self, // кто наблюдатель — этот viewcontroller
            selector: #selector(didUpdate), //что делать, когда получишь уведомление
            name: Notification.Name(rawValue: notificationName), // имя уведомления, чтобы его отслеживать
            object: nil // здесь можно передать какие то данные и обработать их потом
        )
        
        if UserDefaults.standard.object(forKey: "Aim") == nil{
            self.addAim()
        }
        
        activeApp.doThis()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout

        layout.minimumLineSpacing = 20
        collectionView.collectionViewLayout = layout
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let oneDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! OneDayCollectionViewCell
    
        let day = dataArray[indexPath.row]
    
        oneDayCell.setData(input: day)
        
        return oneDayCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: getDataAboutSize(day: dataArray[indexPath.row]))

    }
    
    func getDataAboutSize(day: oneDayInfo) -> CGFloat{
        
        var height : CGFloat = 0
        
        if day.isGoalReached{
            height = 141
        }else{
            height = 105
        }
        
        return height
    }
    
    
    @objc private func didUpdate(){
        dataArray = activeApp.result!
        self.collectionView.reloadData()
    }
    
    private func addAim(){
        
        let alert = UIAlertController(title: "Add new aim", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Input your name here..."
            textField.keyboardType = .numberPad
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            if let name = alert.textFields?.first?.text {
                self.activeApp.newAim = Int(name)!
            }
        }))
        
        self.present(alert, animated: true)
    }

}
