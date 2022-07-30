//
//  ContentViewModel.swift
//  NetworkingExample
//
//  Created by OO E on 1.05.2021.
//

import Foundation
import Networking
import Combine

final class ContentViewModel: ObservableObject {
    
    @Published var myWords: [MyWordsObject] = []
    
    private let service: MyWordsServiceProtocol
    
    var count : Int {
        myWords.count
    }
    
    init(service: MyWordsServiceProtocol) {
        self.service = service
    }
    
    func getMyWordsList() {
        service.getMyWords { [weak self] words in
            guard let self = self,
                  let words = words else {
                return
            }
            self.myWords = words
        } errorBlock: { error in
            print(error)
        }
    }
    
    func register() {
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
