//
//  HomeViewUITests.swift
//  Tests iOS
//
//  Created by Lucas Silveira on 28/02/21.
//

import XCTest

class AppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    let alertDescription = "“PhotoGrid” Would Like to Access Your Photos"
    
    func givePermissions() {
        addUIInterruptionMonitor(withDescription: alertDescription) { (alert) -> Bool in
            alert.buttons.element(boundBy: 1).tap()
            return true
        }
    }
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testShouldAddANewPhotoAndCounts1OnTheList() {
        givePermissions()
        let text = app.staticTexts["zeroPhotosFound"].label
        XCTAssertEqual(text, "Add a new photo to your PhotoGrid!")
        
        app.buttons["add"].tap()
        app.buttons["Photos"].tap()
        app.images.element(boundBy: 3).tap()
        
        sleep(10)
        XCTAssertEqual(app.staticTexts["1"].label, "1")
        XCTAssertTrue(app.staticTexts["Photos"].exists)
    }
}
