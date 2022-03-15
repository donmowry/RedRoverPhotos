//
//  ServerMessageError.swift
//  
//
//  Created by Don on 3/15/22.
//

import Foundation

public struct ServerMessageErrorWrapper: Codable {
    public let error: ServerMessageError
}

public struct ServerMessageError: Codable {
    public let code: String
    public let message: String
}
