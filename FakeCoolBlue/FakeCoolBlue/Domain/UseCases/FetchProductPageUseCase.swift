//
//  FetchProductPageUseCase.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

protocol FetchProductPageUseCaseProtocol {
    func execute(for pageNumber: Int, search criteria: String?) async throws -> ProductPage
}

class FetchProductPageUseCase: FetchProductPageUseCaseProtocol {
    private let repository: ProductPageRepositoryProtocol

    init(repository: ProductPageRepositoryProtocol) {
        self.repository = repository
    }

    func execute(for pageNumber: Int, search criteria: String?) async throws -> ProductPage {
        return try await repository.fetchProductPage(for: pageNumber, search: criteria)
    }
}
