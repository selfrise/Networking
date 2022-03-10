//
//  MyWordsObject.swift
//  NetworkingExample
//
//  Created by Tolga YILDIRIM on 10.03.2022.
//

// MARK: - Result
struct MyWordsObject: Decodable {
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
struct R: Decodable {
    let type: String?
    let coordinates: [Double]?
}
