//
//  MSError.swift
//  BookListTests
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import Foundation

// MARK: - MSError
struct MSError: Error, Codable {
    let httpStatus: Int?
    let message: String?
    var errorMessage: String? {
        guard let statusCode = httpStatus else { return nil }
        return message?.replacingOccurrences(of: String(statusCode), with: "").trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    enum CodingKeys: String, CodingKey {
        case httpStatus = "status"
        case message = "error"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.httpStatus = try container.decodeIfPresent(Int.self, forKey: .httpStatus) ?? 0
        self.message = try container.decodeIfPresent(String.self, forKey: .message) ?? ""
    }
    
    init(httpStatus: Int, message: String) {
        self.httpStatus = httpStatus
        self.message = message
    }
}
