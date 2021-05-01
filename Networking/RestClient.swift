//
//  RestClient.swift
//  Networking
//
//  Created by OOE on 1.05.2021.
//

import Foundation
import UIKit

private let tag = "RestClient"
private func printTagged(_ string: String) {
    print("[" + tag + "] " + string)
}

public class RestClient {
    public enum Error: Swift.Error {
        public enum Data: Swift.Error {
            case missing
            case read(underlying: DecodingError)
            case write(underlying: EncodingError)
        }
        
        case corruptedURL
        case existingIdentifier
        case connection(reason: Swift.Error)
        case http(code: Int)
        case data(reason: Data)
        case server(code: Bool, description: String)
        case other
    }
    
    public static let `default`: RestClient = RestClient()
    
    private static var baseUrl: String = ""
    
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private let urlSession: URLSession
    private var taskPool: [String : Weak<URLSessionTask>] = [:]
    static var header: [String: String]?
    
    private init() {
        self.urlSession = URLSession.init(configuration: .default, delegate: nil, delegateQueue: .main)
    }
    
    init(session: URLSession) {
        self.urlSession = session
    }
    
    @discardableResult
    private func makeRequest<Q: Request, S: Decodable>(identifier: String?, request: Q, body: Data?, completionHandler: @escaping (S?, Error?) -> Void) -> URLSessionTask? {
        
    
        var baseUrl: String = ""
        if request is GenericRequest  {
            let genericRequest = request as! GenericRequest
            baseUrl = genericRequest.baseUrl != nil ? genericRequest.baseUrl! : RestClient.baseUrl
        } else {
            baseUrl = RestClient.baseUrl
        }
        
        guard let url = URL(string: baseUrl + request.constructedURL) else {
            completionHandler(nil,.corruptedURL)
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = body
        urlRequest.timeoutInterval = 30.0
        urlRequest.allHTTPHeaderFields = RestClient.header
        urlRequest.setValue(request.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        if request.headerParameters.count > 0 {
            for parameters in request.headerParameters {
                urlRequest.setValue(parameters.value, forHTTPHeaderField: parameters.name)
            }
        }
        
        self.debugRequestAndHeader(request: request, urlRequest: urlRequest, identifier: identifier, body: body)
        
        let task = urlSession.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            let _ = identifier.map { self?.taskPool.removeValue(forKey: $0) }
            
            #if DEBUG
            printTagged("🟧🟧🟧🟧🟧🟧 <----------Response----------> 🟧🟧🟧🟧🟧🟧")
            identifier.map { printTagged("Identifier: " + $0) }
            printTagged("Method: " + request.method.rawValue)
            printTagged("URL: " + RestClient.baseUrl + request.constructedURL)
            
            defer {
                printTagged("🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧")
            }
            #endif
            
            if let error = error {
                #if DEBUG
                printTagged("🚫Connection Error: " + error.localizedDescription)
                #endif
                
                completionHandler(nil, .connection(reason: error))
                
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                #if DEBUG
                printTagged("🚫     !!!NO RESPONSE!!!     ")
                #endif
                
                completionHandler(nil, .other)
                
                return
            }
            
            if response.statusCode < 200 || response.statusCode >= 400 {
                #if DEBUG
                printTagged("🚫HTTP Error: " + String(describing: response.statusCode))
                #endif
                
                completionHandler(nil, .http(code: response.statusCode))
            } else {
                guard let data = data else {
                    #if DEBUG
                    printTagged("🚫       !!!NO DATA!!!       ")
                    #endif
                    
                    completionHandler(nil, .data(reason: .missing))
                    
                    return
                }
                
                #if DEBUG
                printTagged("🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧🟧")
                printTagged("Response: " + (String(data: data, encoding: .utf8) ?? "CORRUPTED"))
                #endif
                do {
                    let response = try RestClient.decoder.decode(S.self, from: data)
                    completionHandler(response, nil)
                } catch let error as DecodingError {
                    completionHandler(nil, .data(reason: .read(underlying: error)))
                    
                } catch {
                    completionHandler(nil, .other)
                }
            }
        }
        
        if let identifier = identifier, !identifier.isEmpty {
            if taskPool.keys.contains(identifier) {
                completionHandler(nil, .existingIdentifier)
                return nil
            }
        }
        
        task.resume()
        return task
    }
    
    @discardableResult
    public func makeRequest<Q: Request & Encodable, S: Decodable>(request: Q, completionHandler: @escaping (S?, Error?) -> Void) -> URLSessionTask? {
        do {
            if request.method == .get{
                return makeRequest(identifier: nil, request: request, body: nil, completionHandler: completionHandler)
            }else {
                let body = try RestClient.encoder.encode(request)
                return makeRequest(identifier: nil, request: request, body: body, completionHandler: completionHandler)
                
            }

        } catch let error as EncodingError {
            completionHandler(nil,.data(reason: .write(underlying: error)))
            return nil
        } catch {
            completionHandler(nil,.other)
            return nil
        }
    }
    
    func cancelRequest(identifier: String) {
        taskPool[identifier]?.object?.cancel()
    }
    
    
}

extension RestClient {
    
    public class func setBaseUrl(url: String) {
        RestClient.baseUrl = url
    }
    
    public class func getBaseUrl() -> String {
        return RestClient.baseUrl
    }
    
    public class func setHeaderValue(header: [String: String]) {
        RestClient.header = header
    }
    
    class func appendHeaderValue(key: String, value: String) {
        if RestClient.header == nil {
            RestClient.header = [String: String]()
            RestClient.header![key] = value
            
        } else {
            RestClient.header![key] = value
        }
    }
    
    class func removeRequestHeaderForKey(key: String) {
        RestClient.header?.removeValue(forKey: key)
    }

}

extension RestClient {
    
    private func debugRequestAndHeader<Q: Request>(request: Q, urlRequest:URLRequest, identifier: String?, body: Data?) {
        #if DEBUG
        printTagged("🔶🔶🔶🔶🔶 ----------Request---------- 🔶🔶🔶🔶🔶")
        identifier.map { printTagged("Identifier: " + $0) }
        printTagged("Method: " + request.method.rawValue + " 🚀")
        printTagged("URL: " + RestClient.baseUrl + request.constructedURL)
        var allHTTPHeaderFields = urlRequest.allHTTPHeaderFields
        
        if request.headerParameters.count > 0 {
            for parameters in request.headerParameters {
                allHTTPHeaderFields?[parameters.name] = parameters.value
            }
        }
        let header1 = allHTTPHeaderFields?.reduce("", { (result, parameter) -> String in
            return result + parameter.key + "=" + parameter.value + ", "
        })
        let header = header1 ?? ""
        printTagged("Header: " + header)
        body.map { String(data: $0, encoding: .utf8).map { printTagged("Body: " + $0) } }
        printTagged("🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶🔶")
        #endif
    }
}
