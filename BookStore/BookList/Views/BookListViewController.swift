//
//  ViewController.swift
//  BookList
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {
    @IBOutlet weak var bookListCollectionView: UICollectionView!
    
    var bookListViewModel: BookListViewModel!
    var dataSource: BookListDataSource<BookListCell, BookViewModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        bookListViewModel = BookListViewModel(webservice: WebServices())
        bookListViewModel.fetchBookList { success in
            if success {
                self.updateDataSource()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func registerNib() {
        bookListCollectionView.register(UINib(nibName: "BookListCell", bundle: .main), forCellWithReuseIdentifier: "BookListCell")
    }
    
    func updateDataSource() {
        
        self.dataSource = BookListDataSource(cellIdentifier: "BookListCell", items: self.bookListViewModel.bookListing) { cell, vm in
            
            if let name = vm.name, let author = vm.artistName, let imageURL = vm.imageURL{
                cell.bookNameLabel.text = name
                cell.authorLabel.text = author
                cell.loadImage(url: imageURL)
            }
        }
        
        self.bookListCollectionView.dataSource = self.dataSource
        self.bookListCollectionView.delegate = self
        self.bookListCollectionView.reloadData()
    }
    
}

extension BookListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "bookDetailSegue", sender: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        bookListCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = collectionView.frame.size.width / (UIDevice.current.userInterfaceIdiom == .phone ? NumberOfColumns.phone: NumberOfColumns.pad)
        cellSize -= DesignConstants.cellPadding
        return CGSize(width: cellSize, height: cellSize)
    }
}
