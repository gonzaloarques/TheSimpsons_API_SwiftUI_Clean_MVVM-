//
//  RemoteImageView.swift
//  TheSimpsons
//
//  Created by Gonzalo Arques on 30/11/25.
//

import Foundation
import SwiftUI

// MARK: - Enums
enum SimpsonsImageSize: Int {
    case character = 500
    case episodeThumbnail = 200
    case location = 1280
}

enum SimpsonsImageAPI {
    static let base = URL(string: "https://cdn.thesimpsonsapi.com/")!
    
    static func url(size: SimpsonsImageSize = .character, imagePath: String) -> URL? {
        let url = "\(base)\(size.rawValue)\(imagePath)"
        return URL(string: url)
    }
}

// MARK: - View
struct RemoteImageView: View {
    let portraitPath: String
    var size: SimpsonsImageSize = .character
    var cornerRadius: CGFloat = 8
    var contentMode: ContentMode = .fill
    var showsProgressView: Bool = true
    
    /// In this case, it is not necessary to create a repository or anything else because we use the
    /// AsyncImage component to obtain the image directly from the API (which has no models or anything,
    /// it only provides the image from the URL)
    private var imageURL: URL? {
        SimpsonsImageAPI.url(size: size, imagePath: portraitPath)
    }
    
    var body: some View {
        Group {
            if let url = imageURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        if showsProgressView {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        else {
                            Color.clear
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .scaled(contentMode)
                    case .failure:
                        placeholder
                    @unknown default:
                        placeholder
                    }
                }
            }
            else {
                placeholder
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
    
    private var placeholder: some View {
        ZStack {
            Color.secondary.opacity(0.15)
            Image(systemName: "photo")
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 28, weight: .regular))
                .foregroundStyle(.secondary)
        }
        .scaled(contentMode)
    }
}

private extension View {
    func scaled(_ mode: ContentMode) -> some View {
        switch mode {
        case .fit:
            AnyView(self.scaledToFit())
        case .fill:
            AnyView(self.scaledToFill())
        @unknown default:
            AnyView(self)
        }
    }
}

// MARK: - Preview
#Preview("Remote image sizes") {
    VStack(spacing: 16) {
        RemoteImageView(portraitPath: "/character/1.webp", size: .character)
            .frame(width: 120, height: 120)
        RemoteImageView(portraitPath: "/episode/1.webp", size: .episodeThumbnail)
            .frame(width: 120, height: 120)
        RemoteImageView(portraitPath: "/location/1.webp", size: .location)
            .frame(width: 120, height: 120)
    }
    .padding()
}
