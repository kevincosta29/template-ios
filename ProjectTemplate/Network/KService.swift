//
//  KService.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 2/5/22.
//


import Foundation

final class KService {
    
    public static func executeRequest<T: Decodable>(endpoint: KEndpointProtocol, model: T.Type, session: URLSession) async -> (Result<T, KNetworkError>) {
        
        let response = await KNetwork.executeRequest(endpoint: endpoint, session: session)
        switch response {
        case .success(let result):
            return manageResponse(result: result, endpoint: endpoint.path)
        case .failure(let error):
            print("❌ - KService: \(error.description) - ERROR - KO")
            return .failure(error)
        }
    }
    
    private static func manageResponse<T: Decodable>(result: (data: Data, statusCode: Int), endpoint: String) -> Result<T, KNetworkError> {
        switch result.statusCode {
        case 200...299:
            guard let dataParsed = try? KParser<T>.parserData(result.data) else {
                print("KService❓: \(endpoint) - STATUS CODE: \(result.statusCode) - ERROR PARSER OBJECT - OK")
                return .failure(KNetworkError.parserError(message: "Can not parser object"))
            }
            print("✅ - KService: \(endpoint) - STATUS CODE: \(result.statusCode) - OK")
            return .success(dataParsed)
        default:
            print("❌ - KService: \(endpoint) - STATUS CODE: - \(result.statusCode) - KO")
            guard let errorResponse = try? KParser<WSErrorResponse>.parserData(result.data) else {
                return .failure(KNetworkError.error(message: "ERROR RESPONSE - STATUS CODE: \(result.statusCode)"))
            }
            return .failure(KNetworkError.error(message: errorResponse.description))
        }
    }
    
}

struct KParser<T: Decodable> {
    public static func parserData(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
