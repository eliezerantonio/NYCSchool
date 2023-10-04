//
//  NYCSchoolTests.swift
//  NYCSchoolTests
//
//  Created by Eliezer Antonio on 29/09/23.
//

import XCTest
@testable import NYCSchool

final class NYCSchoolTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {

        var sum = 2 + 2
        XCTAssert(sum == 4)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGettingSchoolsWithMockEmptyResult(){
        let expectation = expectation(description: "testing empty mock api")
        
        let mockApi = MockSchoolAPI()
        mockApi.loadState = .empty
        
        
        let viewModel = SchoolsViewModel(apiService: mockApi)
        
        viewModel.getSchools { schools, error in
            XCTAssertTrue(schools?.isEmpty == true, "Expected schools to be empty, bu received some values")
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 1.0){ error in
            if let error = error {
                XCTFail("Expectation failed \(error)")
            }
        }
    }
    
    func testGettingSchoolwithErrorResult(){
        let expectation = expectation(description: "testion empty mock api")
        
        let mockAPI = MockSchoolAPI()
        mockAPI.loadState = .error
        
        let viewModel = SchoolsViewModel(apiService: mockAPI)
        viewModel.getSchools { schools, error in
            XCTAssertTrue(schools == nil, "Expected to get no schools and error, but receid schools")
            XCTAssertNotNil(error, "Expected to get an error, but receives no error")
            
            expectation.fulfill()
            
            
        }
        
        waitForExpectations(timeout: 1.0) { error in
            if let error = error {
                XCTFail("Expecation falid \(error)")
            }
            
        }
        
    }
    
    func testGettingSchoolsWithSuccess (){
        let expectation = expectation(description: "testin success state with mock api")
        
        let mockAPi = MockSchoolAPI()
        mockAPi.loadState = .loaded
        
        let viewModel = SchoolsViewModel(apiService: mockAPi)
        
        viewModel.getSchools{ schools, error in
            XCTAssert(schools?.isEmpty == false, "Expected to get schools")
            XCTAssertNil(error, "Expected error to be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0){ error in
            if let error = error {
                XCTFail("Expectation falid \(error)")
            }
            
        }
        
        
    }

}
