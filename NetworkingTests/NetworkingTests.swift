//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by OO E on 1.05.2021.
//

import XCTest
@testable import Networking

class NetworkingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPostRequest() {
        
        let request = RegisterRequest(email: "aaa@gmail.com", password: "123456", confirmPassword: "123456")
       
        RestClient.default.makeRequestWithError(request: request) { (response: String?, error: RestClient.Error?, model: ErrorModel?) in
           
            if let _error = error{
                //handler(.failure(_error))
                return
            } else if let _response = response {
               // handler(.success(_response))
                return
            }
            
        }
        
        
        
    }
}
