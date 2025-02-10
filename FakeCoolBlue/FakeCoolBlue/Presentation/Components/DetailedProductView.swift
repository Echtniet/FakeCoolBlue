//
//  DetailedProductView.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import SwiftUI

struct DetailedProductView: View {

    let animation: Namespace.ID
    let product: Product
    let onClose: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.gray)
                .background(Color.white)
                .clipShape(Circle())
                .onTapGesture {
                    onClose()
                }
            ProductImageView(animation: animation, id: product.productId, urlString: product.productImage, width: .infinity, height: 240)
            Text(product.productName)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
                .bold()
                .matchedGeometryEffect(id: "title_\(product.productId)", in: animation)
            if product.nextDayDelivery {
                Text("Order before 17:00 and get next day delivery")
            }
            UniqueSellingPointView(animation: animation, product: product)
            HStack {
                Text("Price:")
                Spacer()
                Text("\(product.salesPriceIncVat.formattedAsEuro())")
            }
            Spacer()
            Button {

            } label: {
                HStack {
                    Text("Add to Cart")
                        .font(.headline)
                        .foregroundColor(.white)
                    Image(systemName:"cart.fill")
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
            }
            .padding(.bottom)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .matchedGeometryEffect(id: "background_\(product.productId)", in: animation)
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

struct UniqueSellingPointView: View {
    let animation: Namespace.ID
    let product: Product
    @State var isExpanded: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text("Unique Selling Points")
                Spacer()
                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
            }
            if isExpanded {
                VStack(alignment: .leading) {
                    ForEach(product.usps, id: \.self) { usp in
                        Text(usp)
                            .font(.footnote)
                            .matchedGeometryEffect(id: usp, in: animation)
                            .opacity(isExpanded ? 1 : 0)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

extension Double {
    func formattedAsEuro() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.locale = Locale(identifier: "nl_NL") // Dutch (Netherlands) locale for Euro formatting

        return formatter.string(from: NSNumber(value: self)) ?? "€\(self)"
    }
}
