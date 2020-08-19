//
//  BookListViewModel.swift
//  BookList
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import UIKit
import Foundation

class BookListViewModel: NSObject {
    var webservice: WebServices
    var bookListing = [BookViewModel]()
    
    init(webservice: WebServices) {
        
        self.webservice = webservice
        super.init()

    }
    
    func fetchBookList(completion: @escaping (_ success: Bool) -> ()) {
        webservice.loadBooks(completion: { responseData, error  in
            if let books = responseData?.feed?.books{
                for book in books{
                    let currentBook = BookViewModel(response: book)
                    self.bookListing.append(currentBook)
                }
            }
            completion(!self.bookListing.isEmpty)
        })
    }
}

class BookViewModel : NSObject {
    
    var id: String?
    var name: String?
    var artistName: String?
    var imageURL: String?
    
    init(response: Book) {
        
        self.id = response.bookId ?? ""
        self.name = response.name ?? ""
        self.artistName = response.artistName ?? ""
        self.imageURL = response.imageURL ?? ""
    }
}
