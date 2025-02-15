//
//  ProductPageDTO.swift
//  FakeCoolBlue
//
//  Created by Clinton on 14/02/2025.
//

import Foundation

struct ProductPageDTO: Codable {
    let products: [ProductDTO]
    let currentPage: Int
    let pageSize: Int
    let totalResults: Int
    let pageCount: Int
}
