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

extension URLRequest {
    
    public func cURL(pretty: Bool = false) -> String {
        let newLine = pretty ? "\\\n" : ""
        let method = (pretty ? "--request " : "-X ") + "\(self.httpMethod ?? "GET") \(newLine)"
        let url: String = (pretty ? "--url " : "") + "\'\(self.url?.absoluteString ?? "")\' \(newLine)"
        
        var cURL = "curl "
        var header = ""
        var data: String = ""
        
        if let httpHeaders = self.allHTTPHeaderFields, httpHeaders.keys.count > 0 {
            for (key,value) in httpHeaders {
                header += (pretty ? "--header " : "-H ") + "\'\(key): \(value)\' \(newLine)"
            }
        }
        
        if let bodyData = self.httpBody, let bodyString = String(data: bodyData, encoding: .utf8),  !bodyString.isEmpty {
            data = "--data '\(bodyString)'"
        }
        
        cURL += method + url + header + data
        
        return cURL
    }
    
}
