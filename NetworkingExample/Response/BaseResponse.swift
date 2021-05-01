//
//  BaseResponse.swift
//  NetworkingExample
//
//  Created by OO E on 1.05.2021.
//

import Foundation

struct BaseListResponse<T: Decodable>: Decodable {
    let success: Bool
    let error: String
    let result: [T]
}


struct BaseResponse<T: Decodable>: Decodable {
    let success: Bool
    let error: String
    let result: T
}
