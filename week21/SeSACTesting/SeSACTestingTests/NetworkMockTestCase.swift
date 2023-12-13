//
//  NetworkMockTestCase.swift
//  SeSACTestingTests
//
//  Created by Alex Cho on 12/13/23.
//

import XCTest
@testable import SeSACTesting

final class NetworkMockTestCase: XCTestCase {
    
    var sut: NetworkProvider! //protocol as a type
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //test double
    //MockData와 DI를 사용해서 할 수 있음
    func testExample() throws {
        sut.fetchLotto { <#LottoResponse#> in
            <#code#>
        }
      
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
