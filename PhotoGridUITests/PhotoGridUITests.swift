//
//  PhotoGridUITests.swift
//  PhotoGridUITests
//
//  Created by Lucas Silveira on 01/03/21.
//

import XCTest

class PhotoGridUITests: XCTestCase {

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
    
    func addNewPhoto() {
        app.buttons["add"].tap()
        sleep(5)
        app.buttons["Photos"].tap()
        app.images.element(boundBy: 3).tap()
    }
    
    func testShouldAddANewPhotoAndCounts1OnTheList() {
        givePermissions()
        let text = app.staticTexts["zeroPhotosFound"].label
        XCTAssertEqual(text, "Add a new photo to your PhotoGrid!")
        
        addNewPhoto()
        
        sleep(10)
        XCTAssertEqual(app.staticTexts["photosCount"].label, "1")
        XCTAssertTrue(app.staticTexts["Photos"].exists)
    }
    
    func testShouldMarkAPhotoAsFavoriteAndSeeOnHome() {
        givePermissions()

        sleep(5)
        let image = app.otherElements["grid"].images.firstMatch
        image.tap()
        
        app.buttons["favorite"].tap()
        app.buttons["close"].tap()
        
        sleep(3)
        
        XCTAssertEqual(app.staticTexts["favoritesCount"].label, "1")
    }
    
    func testShouldRemoveLastPhotoAdded() {
        givePermissions()

        sleep(5)
        let image = app.otherElements["grid"].images.firstMatch
        image.press(forDuration: 1)

        app.alerts.firstMatch.buttons.element(boundBy: 1).tap()

        sleep(3)
        XCTAssertFalse(app.staticTexts["Photos"].exists)
        XCTAssertFalse(app.staticTexts["Favorites"].exists)
    }
}
