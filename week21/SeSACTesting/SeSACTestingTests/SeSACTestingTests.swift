//
//  SeSACTestingTests.swift
//  SeSACTestingTests
//
//  Created by Alex Cho on 12/8/23.
//

import XCTest
@testable import SeSACTesting
//LoginVC, valid method
final class SeSACTestingTests: XCTestCase {
    
    var sut: LoginViewController! //System Under Test 인스탄스화 하지 않는 이유는 이닛 디이닛이 명시

    override func setUpWithError() throws {
        print(#function)
        //테스트 시작 전 값 세팅
//        sut = LoginViewController() //storyboard이기 때문에 별도로 생성해야함
        //이렇게 하면 되지만 기존 파일 변경시 같이 변경되어야 할 지점이 많으므로 스토리보드는 테스트하기 좋은 코드라고 보기 어렵다.
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        sut = vc
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        print(#function)
        //테스트 이후 초기화 (nil)
        sut = nil
    }

    //함수 시그니쳐 중요. 파일, 목적, 예상값
    //성공하던 테스트가 어느 순간 실패를 한다면 기존 코드의 문제가 생긴것
    func testLoginViewController_ValidEmail_ReturnTrue() throws {
        print(#function)
        sut.emailTextField.text = "alex@test.com"
        XCTAssertTrue(sut.isValidEmail(), "@없거나 6글자 미만임")
    }
    
    //테스트 결과가 성공이지만, 사실 실패케이스를 테스트 한것. 이렇게 하는 이유는 CI에서 테스트 통과가 되어야 빌드가 되기 때문
    func testLoginViewController_ValidEmail_ReturnFalse() throws {
        print(#function)
        sut.emailTextField.text = "alextest.com"
        XCTAssertFalse(sut.isValidEmail(), "@없거나 6글자 미만임")
    }
//    
//    func testLoginViewController_Test_ReturnNil() throws {
//        print(#function)
//        sut.emailTextField = nil
//        XCTAssertNil(sut.emailTextField == nil, "NIL")
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
