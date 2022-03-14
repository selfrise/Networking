//
//  MyWordsServiceProtocol.swift
//  NetworkingExample
//
//  Created by Tolga YILDIRIM on 10.03.2022.
//

import Foundation
import Networking

protocol MyWordsServiceProtocol {
    func getMyWords(successBlock: @escaping (_ response: [MyWordsObject]?) -> (), errorBlock: @escaping (_ error: RestClient.Error) -> ())
}

final class MyWordsService: MyWordsServiceProtocol {
    
    func getMyWords(successBlock: @escaping ([MyWordsObject]?) -> (), errorBlock: @escaping (RestClient.Error) -> ()) {
        let myWordsRequest = MyWordRequest()
        RestClient.default.makeRequest(request: myWordsRequest) { (_ response: Response<[MyWordsObject]>?, error: RestClient.Error?) in
            if let _error = error {
                errorBlock(_error)
                return
            }else if let _response = response {
                successBlock(_response.result)
                return
            }
        }
    }
}
