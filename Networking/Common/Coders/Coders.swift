//
//  Coders.swift
//  Networking
//
//  Created by Tolga YILDIRIM on 11.03.2022.
//

import Foundation

public enum Coders {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
