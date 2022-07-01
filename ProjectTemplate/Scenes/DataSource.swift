//
//  DataSource.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 29/6/22.
//

import Foundation

class DataSource {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchContent() async -> (Result<[IndDocument], KNetworkError>) {
        let response = await KService.executeRequest(endpoint: TemplateEndpoint.wsCollectionGlosary, model: [IndDocument].self, session: session)
        switch response {
        case .success(let result):
            return .success(result)
        case .failure(let error):
            return .failure(error)
        }
    }
}
