//
//  ProductPageRepository.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

protocol ProductPageRepositoryProtocol {
    func fetchProductPage(for pageNumber: Int, search criteria: String?) async throws -> ProductPage
}

class BlankRepository: ProductPageRepositoryProtocol {
    private let apiService: APIServiceProtocol

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    func fetchProductPage(for pageNumber: Int, search criteria: String?) async throws -> ProductPage {
        return try await apiService.fetchProductPage(for: pageNumber, search: criteria)
    }

}
