//
//  BookDetailDataSource.swift
//  BookList
//
//  Created by Hepsiba on 19/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import UIKit

class BookDetailDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var cellIdentifier :String!
    private var items :[FooterElement]!
    var configureCell :(InfoCollectionViewCell,FooterElement) -> ()
    
    init(cellIdentifier :String, items :[FooterElement], configureCell: @escaping (InfoCollectionViewCell,FooterElement) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            self.items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! InfoCollectionViewCell
            
            let item = self.items[indexPath.row]
            self.configureCell(cell,item)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.size.width/NumberOfColumns.footer, height: 95)
        }
        
        
    }
