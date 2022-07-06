//
//  LoadingView.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 1/7/22.
//

import SwiftUI

struct LoadingView: View {
    
    let text: String
    
    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text(text)
                .bold()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(text: "Loading Data")
    }
}
