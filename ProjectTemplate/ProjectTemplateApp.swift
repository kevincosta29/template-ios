//
//  ProjectTemplateApp.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 20/6/22.
//

import SwiftUI

@main
struct ProjectTemplateApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
