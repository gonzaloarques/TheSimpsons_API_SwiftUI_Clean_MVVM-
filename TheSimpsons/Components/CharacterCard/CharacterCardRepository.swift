//
//  CharacterCardRepository.swift
//  TheSimpsons
//
//  Created by Gonzalo Arques on 29/11/25.
//

import Foundation

// MARK: - Protocol
protocol CharacterCardDataRepository {
    var url: URL { get }
}

// MARK: - Extension of the protocol with its methods
extension CharacterCardDataRepository {
    func fetchCharacters() async throws -> [CharacterCardModel] {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode)
        else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dataDecoded = try decoder.decode(CharactersResultsModelDTO.self, from: data)
        return dataDecoded.results.map(\.toCard)
    }
}

// MARK: - Repository
struct CharacterCardRepository: CharacterCardDataRepository {
    var url: URL {
        URL(string: "https://thesimpsonsapi.com/api/characters")!
    }
}
