//
//  MarvelTeamTests.swift
//  MarvelTeamTests
//
//  Created by Eduardo Jordan on 28/1/22.
//

import XCTest
@testable import MarvelTeam

class MarvelTeamTests: XCTestCase {
    
    var viewModelCharacter: ViewModelCharacter!
    
    override func setUp() {
        super.setUp()
        viewModelCharacter = ViewModelCharacter()
        
    }
    
    override func tearDown() {
        viewModelCharacter = nil
        super.tearDown()
    }
    
    func test_valid_page() throws {
        XCTAssertNoThrow(viewModelCharacter.retrieveData(page: 1))
    }
    
    func test_character_not_nil() throws {
        XCTAssertNotNil(viewModelCharacter.characterData)
    }
    
    
    
}
