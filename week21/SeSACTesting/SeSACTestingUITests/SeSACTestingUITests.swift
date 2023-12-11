//
//  SeSACTestingUITests.swift
//  SeSACTestingUITests
//
//  Created by Alex Cho on 12/8/23.
//

import XCTest

final class SeSACTestingUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testTextFields() throws {
           let app = XCUIApplication()
        app.launch()

           // Test email text field
           let emailTextField = app.textFields["emailTextField"]
           XCTAssertTrue(emailTextField.exists)
           emailTextField.tap()
           emailTextField.typeText("test@example.com")

           // Test id text field
           let idTextField = app.textFields["idTextField"]
           XCTAssertTrue(idTextField.exists)
           idTextField.tap()
           idTextField.typeText("userID123")

           // Test password text field
           let passwordTextField = app.textFields["passwordTextField"]
           XCTAssertTrue(passwordTextField.exists)
           passwordTextField.tap()
           passwordTextField.typeText("password123")

           // Optionally, you can add assertions to check the text values
           XCTAssertEqual(app.staticTexts["test@example.com"].label, "test@example.com")
           XCTAssertEqual(app.staticTexts["userID123"].label, "userID123")
           XCTAssertEqual(app.staticTexts["password123"].label, "password123")

           // You can also take screenshots or perform other actions as needed
           // app.screenshot("TextFieldsFilled")

           // Example: Tap the screen to dismiss the keyboard

           // Additional test steps can be added based on your UI flow
       }
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        //객체 아이덴티파이어
        app.textFields["idTextField"].tap()
        app.textFields["idTextField"].typeText("myID")
        
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("myEmail@email.com")
        
        app.textFields["passwordTextField"].tap()
        app.textFields["passwordTextField"].typeText("myPassword")
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    //login and navigation
    func testExample2() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        //객체 아이덴티파이어
        app.textFields["idTextField"].tap()
        app.textFields["idTextField"].typeText("myID")
        
        app.textFields["emailTextField"].tap()
        app.textFields["emailTextField"].typeText("myEmail@email.com")
        
        app.textFields["passwordTextField"].tap()
        app.textFields["passwordTextField"].typeText("myPassword")
        
        app.buttons["loginButton"].tap()
        XCTAssertTrue(app.staticTexts["Logged In"].exists, "Cannot See Login Text") //UITest에선 이미지, view들이 있냐 없냐 기준으로 보기도 함.
//        XCTAssertFalse(<#T##expression: Bool##Bool#>)
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
