//
//  ViewModel.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 20/6/22.
//

import Foundation

@MainActor
final class ViewModel: ObservableObject {
    
    private let dataSource: DataSource
    @Published var arrayCharacters = [Character]()
    @Published var status: StatusViewModel = .loading
    
    init(dataSource: DataSource = DataSource()) {
        self.dataSource = dataSource
    }
    
    func fetchDocuments() {
        status = .loading
        Task {
            let response = await dataSource.fetchContent()
            switch response {
            case .success(let array):
                status = .success
                self.arrayCharacters = array
            case .failure(let error):
                status = .error(msg: error.description)
            }
        }
    }
    
}

enum StatusViewModel {
    case loading
    case success
    case error(msg: String)
}
