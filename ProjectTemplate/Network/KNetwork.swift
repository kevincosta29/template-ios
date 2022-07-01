//
//  KNetwork.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 2/5/22.
//

import Foundation

class KNetwork {
    
    public static func executeRequest(endpoint: KEndpointProtocol, session: URLSession) async -> Result<(data: Data, statusCode: Int), KNetworkError> {
        
        guard let request = FactoryEndpoint.setup(endpoint: endpoint) else {
            return .failure(KNetworkError.invalidRequest)
        }
        
        do {
            print("⬆️ - KNetwrok Request: \(request.url?.absoluteString ?? "")")
            let (data, response) = try await session.data(for: request)
            print("⬇️ - KNetwrok Response: \(request.url?.absoluteString ?? "")")
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(KNetworkError.invalidResponse)
            }
            return .success((data, httpResponse.statusCode))
        } catch let err {
            return .failure(KNetworkError.error(message: err.localizedDescription))
        }
    }
    
}
