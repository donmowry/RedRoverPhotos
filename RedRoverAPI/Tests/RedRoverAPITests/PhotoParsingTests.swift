//
//  PhotoParsingTests.swift
//
//
//  Created by Don on 3/13/22.
//

import XCTest
@testable import RedRoverAPI

class PhotoParsingTests: XCTestCase {

    func testParsingCorrect() throws {
        // GIVEN: JSON
        guard let url = Bundle.module.url(forResource: "photos", withExtension: "json") else {
            XCTFail("Could not load fixture manifest.json from the bundle")
            return
        }

        let json = try Data(contentsOf: url)
        
        // GIVEN: a parser
        let parser = Parser<PhotosWrapper>()
        
        // WHEN: we ask the parser to parse
        let results = try parser.parseObject(jsonData: json)
        
        // THEN: the data is what we expect
        XCTAssertEqual(results.photos.count, 4)
    }
    
    func testParsingIncorrect() throws {
        // GIVEN: Bad JSON
        let json = "bad data".data(using: .utf8)!
        
        // GIVEN: a parser
        let parser = Parser<PhotosWrapper>()
        
        // WHEN: we ask the parser to parse
        // THEN: an error is thrown
        XCTAssertThrowsError(try parser.parseObject(jsonData: json))
    }

}
