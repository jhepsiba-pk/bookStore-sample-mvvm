//
//  BookListResponse.swift
//  BookList
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import Foundation

struct Book : Codable {
	let artistName : String?
	let bookId : String?
	let releaseDate : String?
	let name : String?
	let kind : String?
	let artistId : String?
	let artistUrl : String?
	let imageURL : String?
	let genres : [Genres]?
	let url : String?

	enum CodingKeys: String, CodingKey {

		case artistName, releaseDate, name, kind, artistId, artistUrl, genres, url
        case imageURL = "artworkUrl100"
        case bookId = "id"

	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
		bookId = try values.decodeIfPresent(String.self, forKey: .bookId)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		kind = try values.decodeIfPresent(String.self, forKey: .kind)
		artistId = try values.decodeIfPresent(String.self, forKey: .artistId)
		artistUrl = try values.decodeIfPresent(String.self, forKey: .artistUrl)
		imageURL = try values.decodeIfPresent(String.self, forKey: .imageURL)
		genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}

}

struct Genres : Codable {
    let genreId : String?
    let name : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case genreId = "genreId"
        case name = "name"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genreId = try values.decodeIfPresent(String.self, forKey: .genreId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
}
