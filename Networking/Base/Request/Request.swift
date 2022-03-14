//
//  Request.swift
//  Networking
//
//  Created by OOE on 1.05.2021.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
    case formURLEncoded = "application/x-www-form-urlencoded"
}

/// It needs to be used when you need to go to another api address
public protocol GenericRequest: Request {
    var baseUrl: String? {get}
}

public protocol Request {
    var method: RequestMethod { get }
    var contentType: ContentType { get }
    var endpoint: String { get }
    var onlyFullPathUrlWithQueries: Bool { get }
    var headerParameters: [URLQueryItem] { get }
    var pathParameters: [URLQueryItem] { get }
    var queryParameters: [URLQueryItem] { get }
}

public extension Request {
    
    var method: RequestMethod {
        .post
    }
    
    var contentType: ContentType {
        .json
    }
    
    var pathParameters: [URLQueryItem] {
        []
    }
    
    var queryParameters: [URLQueryItem] {
        []
    }
    
    var headerParameters: [URLQueryItem] {
        []
    }
    
    var onlyFullPathUrlWithQueries: Bool {
        false
    }
}
