//
//  WarningViewController.swift
//  vWarning1.1
//
//  Created by DatTran on 7/12/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import UIKit

class WarningViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var presenter: WarningPresenter?
    
    private var arrayDataSource: ArrayDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        setupNavigation()
        
        self.presenter = WarningPresenter.init(model: WarningModel(), view: self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.presenter?.displayViewFromWarningModel()
        }
    }
    
    func setupView() {
    
        collectionView?.backgroundColor = UIColor.whiteColor()
      
        collectionView?.alwaysBounceVertical = true
        collectionView?.registerClass(WarningView.self, forCellWithReuseIdentifier: "a")
        
    }
    
    func setupNavigation() {
    
        navigationItem.title = "W"
        let out = UIBarButtonItem(title: "out", style: .Plain, target: self, action: #selector(WarningViewController.handleOut))
        navigationItem.leftBarButtonItems = [out]
        navigationController?.navigationBar.barTintColor = SaveColor.BACKGROUND
        
    }

}

extension WarningViewController: WarningViewDelegate {
    
    func displayWarning(warnings: NSArray) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
        
        
        self.setupView()
        let arrayDataSource = ArrayDataSource(items: warnings as! Array<NSObject>, cellIdentifier: "a", configureCellBlock: { (cell , item) -> Void in
            
            if let ce = cell as? WarningView {
                
                if let it = item as? WarningObj {
                    ce.updateCell(it.sensorName, dateTime: it.createdTime)
                }
            }
            
        }) { (cell, item) -> Void in
            
        }
        self.arrayDataSource            = arrayDataSource
        self.collectionView!.delegate     = arrayDataSource
        self.collectionView!.dataSource   = arrayDataSource
        self.collectionView!.reloadData()

        }
    }
    
}

extension WarningViewController {
    
    func handleOut () {
        self.dismissViewController()
    }
    
}