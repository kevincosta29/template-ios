//
//  ViewModel.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 20/6/22.
//

import Foundation

class ViewModel: ObservableObject {
    
    private let session: URLSession
    private let dataSource: DataSource
    @Published var arrayDocuments = [IndDocument]()
    @Published var errorMessage: String = ""
    @Published var isLoading = false
    
    init(session: URLSession = URLSession(configuration: .default), dataSource: DataSource = DataSource()) {
        self.session = session
        self.dataSource = dataSource
    }
    
    func fetchDocuments() {
        isLoading = true
        Task { @MainActor in
            let response = await dataSource.fetchContent()
            switch response {
            case .success(var array):
                var i = 0
                for index in 0..<array.count {
                    array[index].id = i
                    i+=1
                }
                self.arrayDocuments = array
            case .failure(let error):
                self.errorMessage = error.description
            }
        }
    }
    
}
