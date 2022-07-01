//
//  APIDecodeResponse.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 2/5/22.
//

// MARK: - Base error response

struct WSErrorResponse: Codable {
    
    var code                : String?
    var message             : String?
    var description         : String {
        return "Code: \(code ?? "") - Message: \(message ?? "")"
    }
    
    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
    
}
