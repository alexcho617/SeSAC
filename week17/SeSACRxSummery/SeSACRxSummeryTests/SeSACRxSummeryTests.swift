//
//  SeSACRxSummeryTests.swift
//  SeSACRxSummeryTests
//
//  Created by jack on 2023/11/06.
import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import SeSACRxSummery

class ValidateViewModelTests: XCTestCase {
    
    var disposeBag: DisposeBag!
    var viewModel: ValidateViewModel!
    var input: ValidateViewModel.Input!
    var output: ValidateViewModel.Output!
    var tapSubject: PublishSubject<Void>! // Declare tapSubject here
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        viewModel = ValidateViewModel()
        
        // Mocking the input
        let textSubject = PublishSubject<String?>()
        let textControlProperty = ControlProperty(values: textSubject.asObservable(), valueSink: textSubject)
        
        tapSubject = PublishSubject<Void>() // Initialize tapSubject here
        
        let tapControlEvent = ControlEvent(events: tapSubject)
        
        input = ValidateViewModel.Input(text: textControlProperty, tap: tapControlEvent)
        output = viewModel.transform(input: input)
    }
    
    override func tearDown() {
        disposeBag = nil
        super.tearDown()
    }
    
    func testValidation() {
        // Given
        let scheduler = TestScheduler(initialClock: 0)
        let textObserver = scheduler.createObserver(String.self)
        let validationObserver = scheduler.createObserver(Bool.self)
        
        // When
        output.text
            .drive(textObserver)
            .disposed(by: disposeBag)
        
        output.validation
            .subscribe(validationObserver)
            .disposed(by: disposeBag)
        
        // Emitting test values
        let testTexts: [String?] = ["hello", "12345678", "short"]
        let expectedValidations: [Bool] = [false, true, false]
        
        for (index, text) in testTexts.enumerated() {
            // Emit text
            scheduler.createColdObservable([.next(10, text)])
                .bind(to: input.text)
                .disposed(by: disposeBag)
            
            // Tap event
            tapSubject.onNext(())
            
            scheduler.start()
            
            // Then
            XCTAssertEqual(textObserver.events[index].value.element, "닉네임은 8글자 이상")
            XCTAssertEqual(validationObserver.events[index].value.element, expectedValidations[index])
        }
    }
    
    func testTapEvent() {
        // Given
        let scheduler = TestScheduler(initialClock: 0)
        let tapObserver = scheduler.createObserver(Void.self)
        
        // When
        output.tap
            .subscribe(tapObserver)
            .disposed(by: disposeBag)
        
        // Tap event
        tapSubject.onNext(())
        
        scheduler.start()
        
        // Then
        XCTAssertEqual(tapObserver.events.count, 1)
    }
}
