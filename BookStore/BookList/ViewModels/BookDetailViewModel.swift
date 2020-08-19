//
//  BookDetailViewModel.swift
//  BookList
//
//  Created by Hepsiba on 19/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import Foundation

class BookDetailViewModel: NSObject {
    
    var webservice: WebServices
    var bookDetails = [FooterElement]()
    
    init(webservice: WebServices) {
        
        self.webservice = webservice
        super.init()
        
    }
    
    func fetchBookDetail(completion: @escaping (_ success: Bool) -> ()) {
        self.bookDetails.append(contentsOf: footerElements)
        completion(!self.bookDetails.isEmpty)
    }
}

//Static Temp data
let footerElements = [FooterElement(title: "GENRE", info: "", subtext: "British Detective"),
                      FooterElement(title: "RELEASED", info: "1892", subtext: "Oct' 14"),
                      FooterElement(title: "LANGUAGE", info: "EN", subtext: "English"),
                      FooterElement(title: "LENGTH", info: "432", subtext: "Pages"),
                      FooterElement(title: "PUBLISHER", info: "", subtext: "Public Domain"),
                      FooterElement(title: "SIZE", info: "383.7", subtext: "KB")]

class FooterElement {
    
    var title: String?
    var info: String = ""
    var subText: String?
    
    init(title: String, info: String?, subtext: String) {
        self.title = title
        self.info = info ?? ""
        self.subText = subtext
    }
}
