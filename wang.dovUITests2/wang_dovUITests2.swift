//
//  wang_dovUITests2.swift
//  wang.dovUITests2
//
//  Created by i564206 on 2022/2/28.
//

import XCTest
@testable import wang_dov

class wang_dovUITests2: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testUpdateView_IfCanUpdateView(){
        let app = XCUIApplication()
        let updateButton = app.navigationBars["Upgrades"].buttons["Add Update"]
        if updateButton.isSelected{
           XCTAssertTrue( app.tables/*@START_MENU_TOKEN@*/.buttons["ContentView, here is ContentView, 2001"]/*[[".cells[\"ContentView, here is ContentView, 2001\"].buttons[\"ContentView, here is ContentView, 2001\"]",".buttons[\"ContentView, here is ContentView, 2001\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        }
        
    }
}
