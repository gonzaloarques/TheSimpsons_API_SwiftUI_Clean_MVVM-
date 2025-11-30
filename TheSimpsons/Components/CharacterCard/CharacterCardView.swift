//
//  CharacterCardView.swift
//  TheSimpsons
//
//  Created by Gonzalo Arques on 29/11/25.
//

import SwiftUI

struct CharacterCardView: View {
    let card: CharacterCardModel
    
    var body: some View {
        let status = card.status
        let statusColor: Color = {
            switch status {
            case .alive: return .green
            case .deceased: return .red
            case .unknown: return .gray
            }
        }()
        
        VStack(alignment: .center, spacing: 8) {
            RemoteImageView(
                portraitPath: card.portraitPath,
                size: .character,
                cornerRadius: 12,
                contentMode: .fill)
            .frame(width: 150, height: 150)
            Text(card.name)
                .font(.headline)
            Text(card.occupation)
                .foregroundStyle(.secondary)
                .padding(.bottom, 10)
            
            HStack(alignment: .center, spacing: 15) {
                if let age = card.age {
                    Text(age)
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Capsule())
                }
                Text(status.rawValue)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(statusColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(statusColor.opacity(0.1))
                    .clipShape(Capsule())
            }
            
            if let firstPhrase = card.phrases.first {
                Text(firstPhrase)
                    .foregroundStyle(.brown)
                    .italic()
                    .multilineTextAlignment(.leading)
                    .padding(.top, 5)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    CharacterCardView(card: .test)
}
