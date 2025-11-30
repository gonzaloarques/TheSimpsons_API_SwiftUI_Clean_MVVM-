//
//  CharacterCardVM.swift
//  TheSimpsons
//
//  Created by Gonzalo Arques on 29/11/25.
//

import SwiftUI

@Observable
final class CharacterCardVM {
    let repository: CharacterCardDataRepository
    var cards: [CharacterCardModel]
    var isLoading: Bool = false
    
    init(repository: CharacterCardDataRepository = CharacterCardRepository()) {
        self.repository = repository
        self.cards = []
    }
    
    func load() async {
        if isLoading { return }
        
        isLoading = true
        do {
            let result = try await repository.fetchCharacters()
            self.cards = result
            isLoading = false
        }
        catch {
            self.cards = []
            isLoading = false
            print("Error fetching characters: \(error)")
        }
    }
}
