//
//  TemplateEndpoint.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 6/4/22.
//

import Foundation

enum TemplateEndpoint: KEndpointProtocol {
    
    case wsCollectionGlosary
    
    var scheme: String {
        return "https"
    }
    
    var port: Int {
        return 443
    }
    
    var urlBase: String {
        return URL_BASE_KNETWORK
    }
    
    var path: String {
        switch self {
        case .wsCollectionGlosary:
            return "/api/index.json"
        }
    }
    
    var parametersBody: Data? {
        return nil
    }
    
    var encoding: KEncoding {
        return .urlEncoding(params: self.parametersBody)
    }
    
    var method: KURLMethod {
        switch self {
        case .wsCollectionGlosary:
            return .GET
        }
    }
    
    var contentType: KContentType {
        return .json
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
