//
//  BookDetailViewController.swift
//  BookList
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookDetailFooterCollectionView: UICollectionView!
    @IBOutlet weak var viewButtonBorderView: UIView!
    @IBOutlet weak var coverImageView: UIImageView!
    var bookDetailViewModel : BookDetailViewModel!
    var dataSource: BookDetailDataSource!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDetailViewModel = BookDetailViewModel(webservice: WebServices())
        bookDetailViewModel.fetchBookDetail { success in
            if success {
                self.updateDataSource()
            }
        }
        coverImageView.addShadowToView(cornerRadius: 0)
        viewButtonBorderView.layer.borderColor = viewButtonBorderView.tintColor.cgColor
        // Do any additional setup after loading the view.
    }
    
    func registerNib() {
        bookDetailFooterCollectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "InfoCollectionViewCell")
     }

    
    func updateDataSource() {
        
        self.dataSource = BookDetailDataSource(cellIdentifier: "InfoCollectionViewCell", items: self.bookDetailViewModel.bookDetails, configureCell: { cell, vm in
            
            cell.titleLabel.text = vm.title
            cell.infoLabel.text = vm.info
            cell.subTextLabel.text = vm.subText

        })
        self.bookDetailFooterCollectionView.dataSource = self.dataSource
        self.bookDetailFooterCollectionView.delegate = self.dataSource

        self.bookDetailFooterCollectionView.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
