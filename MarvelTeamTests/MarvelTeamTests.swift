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
    
    func testDataTask() {
        let marvelAPI = MarvelAPI()
        let url =  URL(string: marvelAPI.basePath + "limit=\(marvelAPI.limit)&offset=\(marvelAPI.marvelPage)&" + marvelAPI.getCredentials())
        
        let promise = expectation(description: "Status code 200")
        let dataTask =   URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
}
