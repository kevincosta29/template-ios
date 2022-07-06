//
//  TemplateEndpoint.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 6/4/22.
//

import Foundation

enum TemplateEndpoint: KEndpointProtocol {
    
    case wsListCharacters
    
    var scheme: String {
        return "https"
    }
    
    var port: Int {
        return 443
    }
    
    var urlBase: String {
        return Constants.Service.urlBase
    }
    
    var path: String {
        switch self {
        case .wsListCharacters:
            return "/api/character"
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
        case .wsListCharacters:
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
