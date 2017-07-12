//
//  ArrayDataSource.swift
//  vWarning1.1
//
//  Created by DatTran on 7/12/29 H.
//  Copyright © 29 Heisei ANSV. All rights reserved.
//

import Foundation
import UIKit

typealias CellBlock = (cell: NSObject, item: NSObject) -> Void

class ArrayDataSource: NSObject {
    
    private
    var items: NSArray = Array<NSObject>()
    var cellIdentifier: String! = ""
    var configureCellBlock: CellBlock?
    var cellSelectionBlock: CellBlock?
    
    override init() {
        super.init()
    }
    
    convenience init(items: Array<NSObject>, cellIdentifier: String, configureCellBlock: CellBlock, cellSelectionBlock: CellBlock) {
        self.init()
        
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureCellBlock
        self.cellSelectionBlock = cellSelectionBlock
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> NSObject {
        
        return self.items.objectAtIndex(indexPath.row) as! NSObject
    }
}

extension ArrayDataSource: UICollectionViewDelegate {
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let item = self.itemAtIndexPath(indexPath)
        if (self.configureCellBlock != nil) {
            self.configureCellBlock!(cell: cell, item: item)
        }
    }
}

extension ArrayDataSource: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = SaveColor.BACKGROUND.colorWithAlphaComponent(0.9)
        return cell
    }

}

extension ArrayDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(UIScreen.mainScreen().bounds.width, 70)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 7.0
    }

    
}