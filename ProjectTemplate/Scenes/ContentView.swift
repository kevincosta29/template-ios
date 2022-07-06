//
//  ContentView.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 20/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.status {
                case .loading:
                    LoadingView(text: "character.list.loading".localized())
                case .success:
                    List {
                        ForEach(viewModel.arrayCharacters) { character in
                            CharacterRow(character: character)
                        }
                    }
                case .error(let strMsg):
                    ErrorView(strMsg: strMsg) {
                        viewModel.fetchDocuments()
                    }
                }
            }.navigationTitle("Rick & Morty")
        }
        .onAppear {
            viewModel.fetchDocuments()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
