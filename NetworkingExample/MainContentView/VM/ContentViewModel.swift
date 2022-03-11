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
}
