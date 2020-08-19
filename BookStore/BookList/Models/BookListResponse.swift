//
//  BookListResponse.swift
//  BookList
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import Foundation

struct BookListResponse : Codable {
	let feed : Feed?

	enum CodingKeys: String, CodingKey {
		case feed
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
	}

}

struct Feed : Codable {
    let title : String?
    let id : String?
    let copyright : String?
    let country : String?
    let icon : String?
    let updated : String?
    let books : [Book]?

    enum CodingKeys: String, CodingKey {

        case title, id, copyright, country, icon, updated
        case books = "results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        books = try values.decodeIfPresent([Book].self, forKey: .books)
    }
}
