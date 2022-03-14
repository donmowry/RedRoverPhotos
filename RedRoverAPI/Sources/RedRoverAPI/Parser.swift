//
//  Parser.swift
//  
//
//  Created by Don on 3/13/22.
//

import Foundation

@frozen public struct Parser<T: Decodable> {
    private let formatter: DateFormatter
    private let decoder: JSONDecoder
    
    public init() {
        self.formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        self.decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(formatter)
    }
    
    public func parseObject(jsonData: Data) throws -> T {
        try decoder.decode(T.self, from: jsonData)
    }
    
    public func parseArray(jsonData: Data) throws -> [T] {
        try decoder.decode([T].self, from: jsonData)
    }
    
}
