//
//  ProductView.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import SwiftUI

struct ProductView: View {

    let animation: Namespace.ID
    let product: Product
    let onSelect: () -> Void

    var body: some View {
        Button {
            onSelect()
        } label: {
            HStack {
                ProductImageView(animation: animation, id: product.productId, urlString: product.productImage)
                Text(product.productName)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .matchedGeometryEffect(id: "title_\(product.productId)", in: animation)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.gradient.opacity(0.2))
                .matchedGeometryEffect(id: "background_\(product.productId)", in: animation)
        )
        .buttonStyle(PlainButtonStyle())
    }
}
