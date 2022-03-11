//
//  MyWordsRequest.swift
//  NetworkingExample
//
//  Created by OO E on 1.05.2021.
//

import Networking

final class MyWordRequest: Request, Encodable {
    
    private var token: String {
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWZjMmE5Y2M3N2U1OGIyNDExY2JlODAwIiwiaWF0IjoxNjA3ODA1NTU5fQ.hIrA5YSe4mdbLzsvyLRh94BYQlth1Fokt_Emn6SfVSw"
    }
    
    var endpoint: String {
        Endpoint.Word.myWords
    }
    
    var method: RequestMethod {
        .get
    }
    
    var headerParameters: [URLQueryItem] {
        [
            URLQueryItem(name: "token", value: token)
        ]
    }
    
    init() {}
}
