//
//  APIService.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

protocol APIServiceProtocol {
    func fetchProductPage(for pageNumber: Int, search criteria: String?) async throws -> ProductPage
}

class APIService: APIServiceProtocol {}
