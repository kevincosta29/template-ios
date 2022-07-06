//
//  DataSource.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 29/6/22.
//

import Foundation

final class DataSource {
    
    private let session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func fetchContent() async -> (Result<[Character], KNetworkError>) {
        let response = await KService.executeRequest(endpoint: TemplateEndpoint.wsListCharacters, model: WSListCharacters.self, session: session)
        switch response {
        case .success(let result):
            if let array = result.results {
                return .success(array)
            } else {
                return .failure(KNetworkError.error(message: "error.noCharactersFound".localized()))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
