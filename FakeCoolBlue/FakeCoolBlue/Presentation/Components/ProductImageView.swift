//
//  ProductImageView.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import SwiftUI

struct ProductImageView: View {
    private let animation: Namespace.ID
    private var id: Int
    private var url: URL?
    private var width: CGFloat
    private var height: CGFloat

    init(animation: Namespace.ID, id: Int, urlString: String, width: CGFloat = 80, height: CGFloat = 80) {
        self.animation = animation
        self.id = id
        if let url = URL(string: urlString) {
            self.url = url
        }
        self.width = width
        self.height = height
    }

    var body: some View {
        // TODO: solve matchedGeometry with AsyncImage
        if let url {
            AsyncImage(url: url) { pahse in
                switch pahse {
                case .empty:
                    //loading rect
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: width, maxHeight: height)
                        .background(.white)
//                        .matchedGeometryEffect(id: "image_\(id)", in: animation)
                        .mask(RoundedRectangle(cornerRadius: 10))
                case .failure(_):
                    // failure image default image
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}
