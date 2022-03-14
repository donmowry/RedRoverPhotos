//
//  URL+Extensions.swift
//  
//
//  Created by Don on 3/13/22.
//

import Foundation

extension URL {
    func appending(queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems
        return urlComponents.url
    }
}
