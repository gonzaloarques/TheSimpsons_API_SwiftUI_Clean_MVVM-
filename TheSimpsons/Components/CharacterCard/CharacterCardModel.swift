//
//  CharacterCardModel.swift
//  TheSimpsons
//
//  Created by Gonzalo Arques on 29/11/25.
//

import Foundation

// MARK: enums
enum CharacterCardStatus: String, Codable {
    case alive = "Alive"
    case deceased = "Deceased"
    case unknown
}

// MARK: - DTOs
struct CharactersResultsModelDTO: Decodable {
    let results: [CharacterCardModelDTO]
}

struct CharacterCardModelDTO: Codable {
    let id: Int
    let age: Int?
    let birthdate: String?
    let gender: String?
    let name: String?
    let occupation: String?
    let portraitPath: String?
    let phrases: [String]?
    let status: String?
}

// MARK: - Conversion
extension CharacterCardModelDTO {
    var toCard: CharacterCardModel {
        let phrasesFormatted = (phrases ?? []).map { "\"\($0)\"" }
        let ageFormatted = age.map { "Age: \($0)" }

        let statusEnum: CharacterCardStatus = {
            switch status?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
            case "alive": return .alive
            case "deceased": return .deceased
            default: return .unknown
            }
        }()

        return CharacterCardModel(
            id: id,
            age: ageFormatted,
            gender: gender ?? "",
            name: name ?? "",
            occupation: occupation ?? "",
            portraitPath: portraitPath ?? "",
            phrases: phrasesFormatted,
            status: statusEnum)
    }
}

// MARK: - Model
struct CharacterCardModel: Identifiable, Hashable {
    let id: Int // Identifiable and unique value for enumerations and navigations (and therefore, we apply both protocols of this struct)
    let age: String?
    let gender: String
    let name: String
    let occupation: String
    let portraitPath: String
    let phrases: [String]
    let status: CharacterCardStatus
}

// MARK: - Example for tests
extension CharacterCardModel {
    static let test = CharacterCardModel(
        id: 1,
        age: "Age: 39",
        gender: "Male",
        name: "Homer Simpson",
        occupation: "Safety Inspector",
        portraitPath: "/character/1.webp",
        phrases: ["\"Doh!\""],
        status: .alive)
}
