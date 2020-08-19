//
//  BookListTests.swift
//  BookListTests
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import XCTest
@testable import BookList

class BookListTests: XCTestCase {
    var bookListViewModel: BookListViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bookListViewModel = BookListViewModel(webservice: WebServices())

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.let promise = expectation(description: "App Landing Contentful API Response is not valid")
        let promise = expectation(description: "Book List Fetch Attempt")
        
        bookListViewModel.webservice.loadBooks{ responseData, error  in
            XCTAssert(responseData != nil)
            XCTAssert(error == nil)
            if let books = responseData?.feed?.books{
                for book in books{
                    let currentBook = BookViewModel(response: book)
                    XCTAssertTrue(currentBook.id != nil)
                    XCTAssertTrue(currentBook.name != nil)
                    XCTAssertTrue(currentBook.artistName != nil)
                    XCTAssertTrue(currentBook.imageURL != nil)
                }
                
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 60)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            bookListViewModel.fetchBookList { success in
            }
        }
    }
    
}
