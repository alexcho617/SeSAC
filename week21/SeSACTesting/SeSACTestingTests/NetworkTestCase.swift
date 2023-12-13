//
//  NetworkTestCase.swift
//  SeSACTestingTests
//
//  Created by Alex Cho on 12/13/23.
//

import XCTest
@testable import SeSACTesting //타겟이 다름에도 불구하고 다른 모듈을 가져와서 테스트 할 수 있게끔 함

final class NetworkTestCase: XCTestCase {
    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        sut = NetworkManager.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //동기 테스트 최적화이기 때문에 네트워크 호출을 기다리지 않음
    //비동기 테스트: Expectation / fulfill / wait
    func testExample() throws {
        print("1")
        let expectation = expectation(description: "Lotto Number Completion Handler")
        
        //비동기 호출
        sut.fetchLotto { lotto in
            print("2")
            print(lotto.drwNo, lotto.drwtNo1)

            XCTAssertLessThanOrEqual(lotto.drwtNo1, 45)
            XCTAssertGreaterThanOrEqual(lotto.drwtNo1, 1)
            
            expectation.fulfill() //정의해둔 expectation이 충족되는 시점에서 호출해서 동작을 수행함을 알려줌
        }
        wait(for: [expectation], timeout: 3) //비동기 작업을 기다린다. 하지만 timeout에 의존하게 된다.
        print("3")
    }
    
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
//옛날 코드
//    override func setUp() {
//        <#code#>
//    }
//    override func tearDown() {
//        <#code#>
//    }

}
