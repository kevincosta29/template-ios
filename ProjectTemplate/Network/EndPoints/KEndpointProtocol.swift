//
//  KEndpointProtocol.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 2/5/22.
//

import Foundation

protocol KEndpointProtocol {
    
    var scheme: String { get }
    var urlBase: String { get }
    var path: String { get }
    var parametersBody: Data? { get }
    var method: KURLMethod { get }
    var contentType: KContentType { get }
    var headers: [String: String] { get }
    var port: Int { get } 
    var encoding: KEncoding { get }
    
}

enum KEncoding {
    case json
    case urlEncoding(params: Data?)
    
    var urlEncodingItems: [URLQueryItem]? {
        switch self {
        case .urlEncoding(let p):
            guard let params = p else { return nil }
            let dictParams = try? JSONSerialization.jsonObject(with: params, options: []) as? [String: Any]
            var queryItems = [URLQueryItem]()
            dictParams?.forEach({ key, value in
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            })
            return queryItems
        default:
            return nil
        }
    }
}

enum KContentType: String {
    case json = "application/json"
    case multipart = "multipart/form-data"
}

enum KURLMethod: String {
    case GET
    case POST
    case PUT
}
