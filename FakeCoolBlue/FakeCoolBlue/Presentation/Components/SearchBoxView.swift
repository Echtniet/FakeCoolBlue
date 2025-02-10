//
//  SearchBoxView.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import SwiftUI

struct SearchBoxView: View {

    @State private var isExpanded: Bool = false
    @Binding var text: String
    var animation: Namespace.ID

    var body: some View {
        HStack {
            if !isExpanded {
                Image(systemName: "magnifyingglass")
                    .font(.title)
                    .foregroundStyle(.gray)
                    .matchedGeometryEffect(id: "searchBox", in: animation)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isExpanded.toggle()
                        }
                    }
            } else {
                TextField("Search...", text: $text)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke( .gray, lineWidth: 2)
                    )
                    .matchedGeometryEffect(id: "searchBox", in: animation)
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }

}
