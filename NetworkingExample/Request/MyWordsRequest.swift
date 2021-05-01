//
//  MyWordsRequest.swift
//  NetworkingExample
//
//  Created by OO E on 1.05.2021.
//

import Foundation
import Networking


class MyWordRequest: Request, Codable {
    
    private var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNWZjMmE5Y2M3N2U1OGIyNDExY2JlODAwIiwiaWF0IjoxNjA3ODA1NTU5fQ.hIrA5YSe4mdbLzsvyLRh94BYQlth1Fokt_Emn6SfVSw"
    
    var path: String {
     return "/word/myword/0/100"
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var headerParameters: [URLQueryItem] {
        return [URLQueryItem(name: "token", value: self.token)]
    }
   
    init() {
    }
    
}


//------- RESPONSE


// MARK: - Result
struct MyWordsObject: Codable {
    let r: R?
    let id, word, defination, example: String?
    let meaning, focus, user: String?
    let notification: Bool?
    let createdAt, updatedAt: String?
    let v: Int?

    enum CodingKeys: String, CodingKey {
        case r
        case id = "_id"
        case word, defination, example, meaning, focus, user, notification
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case v = "__v"
    }
}

// MARK: - R
struct R: Codable {
    let type: String?
    let coordinates: [Double]?
}

