//
//  Rovers.swift
//  
//
//  Created by Don on 3/13/22.
//

import Foundation

@frozen public enum Rovers: String, CaseIterable, Comparable {
    case curiosity = "Curiosity"
    case opportunity = "Opportunity"
    case spirit = "Spirit"
    
    public static func < (lhs: Rovers, rhs: Rovers) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

