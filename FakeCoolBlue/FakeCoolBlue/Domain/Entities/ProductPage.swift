//
//  ProductPage.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

struct ProductPage: Codable {
    let products: [Product]
    let currentPage: Int
    let pageSize: Int
    let totalResults: Int
    let pageCount: Int

    init(dto: ProductPageDTO) {
        self.products = dto.products.map { Product(dto: $0) }
        self.currentPage = dto.currentPage
        self.pageSize = dto.pageSize
        self.totalResults = dto.totalResults
        self.pageCount = dto.pageCount
    }
}
