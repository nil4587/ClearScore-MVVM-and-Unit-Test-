//
//  DashboardViewModelTests.swift
//  ClearScoreAppTests
//
//  Created by Nileshkumar Mukeshbhai Prajapati on 2021/10/07.
//

import XCTest
@testable import ClearScoreApp

class DashboardViewModelTests: XCTestCase {

    var viewModel: DashboardViewModel!
    
    class MockDelegate: NSObject, DashboardViewModelDelegate {
        var expectation: XCTestExpectation!
        
        func creditScoreSuccess() {
            XCTFail()
        }
        
        func creditScoreFailure(with errorMessage: String) {
            XCTFail()
        }
    }
    
    class MockSuccessDelegate: MockDelegate {
        override func creditScoreSuccess() {
            expectation.fulfill()
        }
    }
    
    class MockFailureDelegate: MockDelegate {
        override func creditScoreFailure(with errorMessage: String) {
            XCTAssert(expectation.description == errorMessage)
            expectation.fulfill()
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testAllPossibleValues() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        viewModel = DashboardViewModel(delegate: MockDelegate())
        XCTAssertFalse(viewModel.dashboardStatus.count > 0)
        XCTAssertFalse(viewModel.creditReportModel != nil)
        XCTAssertFalse(viewModel.totalScore > 0)
        XCTAssertFalse(viewModel.score > 0)
        XCTAssertFalse(viewModel?.isScoreAvailable == true)
    }
    
    func testWebserviceFailureDueToInvalidURL() {
        let failureDelegate = MockFailureDelegate()
        failureDelegate.expectation = XCTestExpectation(description: "invalid_url".localised())
        viewModel = DashboardViewModel(delegate: failureDelegate)
        viewModel.fetchCreditScoreData(using: nil)
        wait(for: [failureDelegate.expectation], timeout: 5.0)
    }
    
    func testWebserviceFailureDueToHostUnavailable() {
        let failureDelegate = MockFailureDelegate()
        failureDelegate.expectation = XCTestExpectation(description: "host_unavailable".localised())
        viewModel = DashboardViewModel(delegate: failureDelegate)
        viewModel.fetchCreditScoreData(using: URL(string: "https://www.dd.com"))
        wait(for: [failureDelegate.expectation], timeout: 15.0)
    }
    
    func testWebserviceSuccess() {
        let successDelegate = MockSuccessDelegate()
        successDelegate.expectation = XCTestExpectation(description: "success".localised())
        viewModel = DashboardViewModel(delegate: successDelegate)
        viewModel.fetchCreditScoreData(using: URL(string: Constants.creditCheckURL))
        wait(for: [successDelegate.expectation], timeout: 5.0)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
}
