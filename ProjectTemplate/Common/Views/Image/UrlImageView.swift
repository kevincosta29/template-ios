//
//  UrlImageView.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 1/7/22.
//

import SwiftUI

struct UrlImageView: View {
    
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(strUrl: String?) {
        urlImageModel = UrlImageModel(urlString: strUrl)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
    }
    
    static var defaultImage = UIImage(named: "NewsIcon")
}

struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(strUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
    }
}
