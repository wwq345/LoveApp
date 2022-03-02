//
//  wang_dovUITests.swift
//  wang.dovUITests
//
//  Created by i564206 on 2022/2/25.
//

import XCTest
@testable import wang_dov

class wang_dovUITests: XCTestCase {

    var app: XCUIApplication!
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testUpdateView_IfCanUpdate(){
       
        XCTAssertEqual(app.navigationBars.textViews.count, app.navigationBars.textViews.count + 1)
       
    }

}
