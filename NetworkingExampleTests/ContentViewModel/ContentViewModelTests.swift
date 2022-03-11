//
//  ContentViewModelTests.swift
//  NetworkingExampleTests
//
//  Created by Tolga YILDIRIM on 11.03.2022.
//

import XCTest
@testable import NetworkingExample
import Networking

final class ContentViewModelTests: XCTestCase {
    private var sut: ContentViewModel!
    private var service: MockMyWordsService!

    override func setUp() {
        service = MockMyWordsService()
        sut = ContentViewModel(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil

        super.tearDown()
    }
    
    func testServiceSuccess() {
        // Given
        service.response = try? ResourceManager.getResponse(bundle: .main, in: Endpoint.Word.myWords)
        
        // When
        sut.getMyWordsList()
        
        // Then
        XCTAssertEqual(sut.myWords.count, 2)
    }
}

fileprivate final class MockMyWordsService: MyWordsServiceProtocol {
    
    var response: Response<[MyWordsObject]>?
    
    func getMyWords(successBlock: @escaping ([MyWordsObject]?) -> (), errorBlock: @escaping (RestClient.Error) -> ()) {
        if let response = response {
            successBlock(response.result)
        } else {
            errorBlock(.other)
        }
    }
}
