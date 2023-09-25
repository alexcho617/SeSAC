//
//  BookToyTests.swift
//  BookToyTests
//
//  Created by Alex Cho on 2023/09/24.
//

import XCTest
@testable import BookToy

final class BookToyTests: XCTestCase {
    private var sut: TimerViewModel!

    override func setUpWithError() throws {
        sut = TimerViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_Toggle() throws {
        //given
        sut.timerState.value = .off
        //when
        sut.mainButtonClicked() //toggle timerState
        //then
        XCTAssert(sut.timerState.value == TimerState.on, "TimerState Toggle")

    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
