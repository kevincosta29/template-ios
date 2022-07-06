//
//  ErrorView.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 1/7/22.
//

import SwiftUI

struct ErrorView: View {
    var strMsg: String
    var action: (() -> Void)?
    var body: some View {
        VStack(spacing: 10) {
            Text(strMsg)
                .font(.body)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                
            Button("Tap here to retry") {
                if let tap = action {
                    tap()
                }
            }
            .foregroundColor(.gray)
            
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(strMsg: "Message error asd")
    }
}
