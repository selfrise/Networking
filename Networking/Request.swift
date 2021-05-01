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

//Başka bir api adresine gitmen gerektiğinde kullanıması gerekiyor
public protocol GenericRequest: Request {
    var baseUrl: String? {get}
}


public protocol Request {
    var method: RequestMethod { get }
    var contentType: ContentType { get }
    var path: String { get }
    var headerParameters: [URLQueryItem] { get }
    var pathParameters: [URLQueryItem] { get }
    var queryParameters: [URLQueryItem] { get }
}

public extension Request {
    
    var method: RequestMethod {
        return .post
    }
    
    var contentType: ContentType {
        return .json
    }
    
    var pathParameters: [URLQueryItem] {
        return []
    }
    
    var queryParameters: [URLQueryItem] {
        return []
    }
    
    var headerParameters: [URLQueryItem] {
        return []
    }
    
    var constructedURL: String {
        let constructedPath = "/"
            + path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            + (pathParameters.count > 0 ? "/" : "")
            + pathParameters.compactMap { (item) in
                return item.value.map { _ in item.name + "/" + (item.value ?? "") }
            }.joined(separator: "/")
        let contructedQuery = (queryParameters.count > 0 ? "?" : "") + queryParameters.compactMap({ (item) in
            return item.value.map { _ in item.name + "=" + (item.value ??  "") }
            }).joined(separator: "&")
        return constructedPath + contructedQuery
    }
}
