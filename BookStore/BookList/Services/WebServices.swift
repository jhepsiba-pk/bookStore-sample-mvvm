//
//  WebServices.swift
//  BookList
//
//  Created by Hepsiba on 18/08/20.
//  Copyright © 2020 Hepsiba. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String:Any]

let AFSession: Session = {
    let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 15
        return configuration
    }()
    return Session(configuration: configuration)
}()

class WebServices {
    
    let sourceURL = URL(string: "https://rss.itunes.apple.com/api/v1/in/books/top-free/all/50/explicit.json")!
    
    func loadBooks(completion: @escaping (_ responseData: BookListResponse?, _ error: Error?) -> ()) {
        makeServiceRequest(sourceURL, completion: { responseData, error  in
            let result = self.parseResponse(BookListResponse.self, responseData, error)
            completion(result.model, result.error)
        })
    }
    
    private func makeServiceRequest(_ url: URLConvertible, completion: @escaping ((_ responseData: Data?, _ error: Error?) -> Void)) {
        
        AFSession.request(url, method: .get, interceptor: nil)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completion(response.data, nil)
                case let .failure(error):
                    completion(response.data, error)
                }
        }
    }
    
    internal func parseResponse<T>(_ type: T.Type, _ data: Data?, _ error: Error?) -> (model: T?, error: MSError?) where T: Decodable {
        let decoder = JSONDecoder()
        if let responseData = data, error == nil {
            do {
                let response = try decoder.decode(type, from: responseData)
                return (response, nil)
            } catch {
                if let error = try? decoder.decode(MSError.self, from: responseData) {
                    return (nil, convertToMSError(error))
                }
            }
        } else if let responseData = data, error != nil {
            if let error = try? decoder.decode(MSError.self, from: responseData) {
                return (nil, error)
            }
        } else if let errorData = error {
            return (nil, convertToMSError(errorData))
        }

        return (nil, convertToMSError(nil))
        }
    internal func convertToMSError(_ error: Error?) -> MSError {
        if let error = error as NSError? {
            return MSError(httpStatus: error.code, message: error.localizedDescription)
        } else {
            return MSError(httpStatus: -1_111, message: error?.localizedDescription ?? "Unknown Error")
        }
    }
}
