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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
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
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("a", forIndexPath: indexPath) as! WarningView
        
        cell.backgroundColor = SaveColor.BACKGROUND
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 100)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5.0
    }
    
}

extension WarningViewController: WarningViewDelegate {
    
    func displayWarning(warnings: NSArray) {
        
        print (3)   
        
    }
    
}

extension WarningViewController {
    
    func handleOut () {
        self.dismissViewController()
    }
    
}