//
//  RegisterService.swift
//  NetworkingTests
//
//  Created by Özgün Ergen on 30.07.2022.
//

import Foundation
import Networking

 struct ErrorModel: Codable {
    let errorMessages: [String]

    enum CodingKeys: String, CodingKey {
        case errorMessages = "ErrorMessages"
    }
}

 class RegisterRequest: GenericRequest, Encodable {
    
    var baseUrl: String? {
        return "https://api.innpith.com"
    }
    
    var endpoint: String {
        return "/api/auth/register"
    }
    
    var onlyFullPathUrlWithQueries: Bool {
        return true
    }
    
    var contentType: ContentType {
        .json
    }
    
    var method: RequestMethod {
        .post
    }
    
    var EmailAddress: String!
    var Password: String!
    var ConfirmPassword: String!
    var LanguageIso6391Code: String!
    var DeviceUuid: String!
    var PushToken: String!
    var DeviceOsType: Int!
    var OsVersion: String!
    var AppVersion: String!
    var IpAddress: String!
   
    
    init(email: String, password: String, confirmPassword: String) {
     
        self.EmailAddress = email
        self.Password = password
        self.ConfirmPassword = confirmPassword
        self.LanguageIso6391Code = "DeviceInfo.languageIso6391Code"
        self.DeviceUuid = "DeviceInfo.udidId"
        self.PushToken = "DeviceInfo.pushToken"
        self.DeviceOsType = 2
        self.AppVersion = "DeviceInfo.appVersion"
        self.IpAddress = "DeviceInfo.ipAddress"
        self.OsVersion = "DeviceInfo.osVersion"
        
    }
}
