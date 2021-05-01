//
//  ContentViewModel.swift
//  NetworkingExample
//
//  Created by OO E on 1.05.2021.
//

import Foundation
import Networking
import Combine


class ContentViewModel:ObservableObject {
    
    @Published var myWords: [MyWordsObject] = []
    
    
    var count : Int {
        return myWords.count
    }
    
    func getMyWordsList() {
        
        
        let myWordsRequest = MyWordRequest()
        RestClient.default.makeRequest(request: myWordsRequest) { [self] (_ response: BaseListResponse<MyWordsObject>?, error: RestClient.Error?) in
            
            guard let _response = response else {
                return
            }
            if let _ = error {
                
                return
            }
            DispatchQueue.main.async {
                myWords = _response.result
            }
        }
    }
    
}
