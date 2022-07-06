//
//  FactoryEndpoint.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 1/7/22.
//

import Foundation

final class FactoryEndpoint {
    
    public static func setup(endpoint: KEndpointProtocol) -> URLRequest? {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.urlBase
        components.path = endpoint.path
        components.port = endpoint.port
        components.queryItems = endpoint.encoding.urlEncodingItems
        
        guard let url = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = endpoint.method.rawValue
        if endpoint.method == .POST || endpoint.method == .PUT {
            urlRequest.httpBody = endpoint.parametersBody
        }
        
        endpoint.headers.forEach { key, value in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        switch endpoint.contentType {
        case .json:
            urlRequest.addValue(endpoint.contentType.rawValue, forHTTPHeaderField: "Content-Type")
        case .multipart:
            urlRequest.setValue("\(urlRequest.httpBody?.count ?? 0)", forHTTPHeaderField: "Content-Length")
        }
        
        return urlRequest
    }
    
}
