//
//  LoginTestCase.swift
//  SeSACTestingTests
//
//  Created by Alex Cho on 12/11/23.
//

import XCTest
@testable import SeSACTesting //internal이지만 테스트를 위해서 타겟 멤버쉽에 일일히 파일들을 추가하지 않아도 되게 해줌


//login validity 검증만 하는 테스트케이스
final class LoginTestCase: XCTestCase {
    var sut: Validator!
    let validUser = User(email: "alex@test.com", password: "1234", check: "1234")
    let invalidUser = User(email: "alextest.com", password: "1234", check: "1234")
    
    override func setUpWithError() throws {
        sut = Validator()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    //뷰 필요 없이 model과 비즈니스 로직만으로 유닛 테스트
    //이렇게 하면 뷰와 로직에 의존성이 낮아져서 테스트하기 쉬워짐
    func testValidator_ValidEmail_ReturnTrue() throws {
        let user = validUser
        let valid = sut.isValidEmail(email: user.email)
        XCTAssertTrue(valid, "없거나 6글자 미만임")
    }

    
    func testValidator_ValidEmail_ReturnFalse() throws {
        let user = invalidUser
        let valid = sut.isValidEmail(email: user.email)
        XCTAssertFalse(valid, "테스트 실패, false가 나와야함")
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
