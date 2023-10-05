//
//  NYCSchoolTests.swift
//  NYCSchoolTests
//
//  Created by Eliezer Antonio on 29/09/23.
//

import XCTest
import Combine
@testable import NYCSchool


final class NYCSchoolsTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func setUp() async throws {
        try await super.setUp()
        cancellables.removeAll()
    }
    
    func testGettingSchoolsWithMockEmptyResult() {
        let expectation = expectation(description: "testing empty state with mock api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .empty
        
        let viewModel = SchoolsViewModel(apiService: mockAPI)
        viewModel.getSchools()
        
        viewModel.$schools
            .receive(on: RunLoop.main)
            .sink { schools in
                XCTAssertTrue(schools.isEmpty == true, "Expected schools to be empty, but received some values")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
    
    func testGettingSchoolsWithErrorResult() {
        let expectation = expectation(description: "testing error state with mock api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .error
        
        let viewModel = SchoolsViewModel(apiService: mockAPI)
        viewModel.getSchools()
        viewModel.$error
            .receive(on: RunLoop.main)
            .sink{ error in
                XCTAssertNotNil(error, "Expected to get an error, but received no error")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
    
    func testGettingSchoolsWithSuccess() {
        let expectation = expectation(description: "testing success state with mock api")
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .loaded
        
        let viewModel = SchoolsViewModel(apiService: mockAPI)
        viewModel.getSchools()
        
        viewModel.$schools
            .receive(on: RunLoop.main)
            .sink { schools in
                XCTAssert(schools.isEmpty == false, "Expected to get schools")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
}
