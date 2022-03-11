//
//  ResourceManager.swift
//  Networking
//
//  Created by Tolga YILDIRIM on 11.03.2022.
//

import Foundation

public final class ResourceManager {
    
    enum ResourceError: Error {
        case responseFileEncodeFailed
        case fileNotFound
    }
    
    public static func getServiceResponse<D: Decodable>(bundle: Bundle, in directory: String, file: String = "response") throws -> D {
        let response: D = try getResponse(bundle: bundle, in: directory, file: file)
        return response
    }
    
    public static func getResponse<D: Decodable>(bundle: Bundle, in directory: String, file: String = "response") throws -> D {
        let data = try getResponseJson(bundle: bundle, in: directory, file: file)
        let decoded = try Coders.decoder.decode(D.self, from: data)
        return decoded
    }
    
    public static func getResponseJson(bundle: Bundle, in directory: String, file: String) throws -> Data {
        guard let url = bundle.url(forResource: file, withExtension: "json", subdirectory: directory) else {
            throw ResourceError.fileNotFound
        }
        let data = try Data(contentsOf: url)
        return data
    }
}

#if DEBUG

extension ResourceManager {
    
    static func saveResponseToDevice(data: Data, for uri: String) {
        DispatchQueue.global(qos: .background).async {
            let responseJson = String(data: data, encoding: .utf8)
            let fileManager = FileManager.default
            guard let documentDirectoryUrl = try? fileManager.url(
                for: .documentDirectory,
                   in: .userDomainMask,
                   appropriateFor: nil,
                   create: true
            ) else {
                return
            }
            
            let path = documentDirectoryUrl.path + "/" + uri
            if !fileManager.fileExists(atPath: path) {
                try? fileManager.createDirectory(
                    atPath: path,
                    withIntermediateDirectories: true,
                    attributes: [.protectionKey: FileProtectionType.complete]
                )
                
            }
            let newFileUrl = URL(fileURLWithPath: path)
            let fileUrl = newFileUrl.appendingPathComponent("response").appendingPathExtension("json")
            do {
                try responseJson?.write(to: fileUrl, atomically: false, encoding: .utf8)
                print("💾Response saved to path: \(path)")
                
            } catch {
                print("Failed to save response with error: \(error.localizedDescription)")
                
            }
        }
    }
}
#endif
