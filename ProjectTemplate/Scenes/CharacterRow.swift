//
//  CharacterRow.swift
//  ProjectTemplate
//
//  Created by Kevin Costa on 1/7/22.
//

import SwiftUI

struct CharacterRow: View {
    
    let character: Character
    
    var body: some View {
        HStack(alignment: .top) {
            UrlImageView(strUrl: character.image)
                .frame(width: 100, height: 100)
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name ?? "-")
                    .font(.title)
                    .bold()
                Text(String(format: "character.row.gender".localized(), character.gender ?? "-"))
                Text(String(format: "character.row.status".localized(), character.status ?? "-"))
                Text(String(format: "character.row.created".localized(),
                            character.created?.formatStrDate(fromFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", toFormat: "dd/MM/yyyy") ?? "-"))
            }
        }
    }
}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(character: Character(id: nil, name: "Rick Sanchez", status: "Alive", species: nil,
                                          type: nil, gender: "Male", image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                                          created: "2017-11-04T18:48:46.250Z"))
            .previewLayout(.fixed(width: 350, height: 200))
    }
}
