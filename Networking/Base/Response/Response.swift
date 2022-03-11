//
//  Response.swift
//  Networking
//
//  Created by Tolga YILDIRIM on 10.03.2022.
//

import Foundation

public struct Response<T: Decodable>: Decodable {
    public let success: Bool
    public let error: String
    public let result: T
}
