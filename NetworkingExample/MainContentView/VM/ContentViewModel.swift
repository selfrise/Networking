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
    
    private let myWordsService: MyWordsServiceProtocol = MyWordsService()
    
    var count : Int {
        myWords.count
    }
    
    func getMyWordsList() {
        myWordsService.getMyWords { [weak self] words in
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
