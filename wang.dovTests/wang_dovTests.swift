//
//  wang_dovTests.swift
//  wang.dovTests
//
//  Created by i564206 on 2022/2/24.
//

import XCTest
@testable import wang_dov

class wang_dovTests: XCTestCase {

    var cardData: CardDataList?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cardData = CardDataList()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cardData = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testDataAdd(){
        _ = cardData
        _ = cardData?.add(data: CardData(text: "happy"))
        XCTAssertEqual(cardData?.dataList[0].text, "happy")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
