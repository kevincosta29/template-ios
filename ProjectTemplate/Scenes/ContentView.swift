//
//  ContentView.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 20/6/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.arrayDocuments) { document in
                    VStack(alignment: .leading) {
                        Text(document.title ?? "")
                        Spacer()
                        Text(document.bite ?? "")
                            .font(.caption)
                            .fontWeight(.light)
                    }
                }
            }
            .navigationTitle("Document")
        }.onAppear {
            viewModel.fetchDocuments()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
