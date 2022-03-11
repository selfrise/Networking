//
//  Endpoint.swift
//  NetworkingExample
//
//  Created by Tolga YILDIRIM on 11.03.2022.
//

enum Endpoint {
    enum Word {
        private static let word = "/word"
        static let myWords = word + "/myword/0/100"
    }
}
