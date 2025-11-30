//
//  ListOfCharactersView.swift
//  TheSimpsons
//
//  Created by Gonzalo Arques on 29/11/25.
//

import SwiftUI

struct ListOfCharactersView: View {
    @State var vm = CharacterCardVM()
    
    var body: some View {
        NavigationStack {
            Group {
                if vm.cards.isEmpty && vm.isLoading {
                    ProgressView("Cargando...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else {
                    List {
                        ForEach(vm.cards) { card in
                            CharacterCardView(card: card)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden) // (only iOS 16+)
                    .background(Color.gray.opacity(0.1))
                    .navigationTitle("The Simpsons")
                }
            }
        }
        .task { await vm.load() }
    }
    
}

#Preview {
    ListOfCharactersView(vm: CharacterCardVM(repository: CharacterCardRepository()))
}

