//
//  MovieTest.swift
//  wang.dovTests
//
//  Created by i564206 on 2022/2/27.
//

import XCTest
@testable import wang_dov

class MovieTest: XCTestCase {

    var mvs: Movie!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mvs = Movie()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mvs = nil
        try super.tearDownWithError()
    }

    func testInit_MovieWithTitle(){
        let testMovie = Movie(title: "Generic Blockbuster")
        
        XCTAssertNotNil(testMovie)
        XCTAssertEqual(testMovie.title, "Generic Blockbuster")
    }
    
    func testEquable_ReturnsTrue(){
        let actionMovie1 = Movie(title: "Action Movie")
        let actionMovie2 = Movie(title: "Action Movie")
        
        XCTAssertEqual(actionMovie1, actionMovie2)
    }

}
