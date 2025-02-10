//
//  ProductIntegrationTests.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import Testing
@testable import FakeCoolBlue
import Foundation

struct ProductIntegrationTests {

    @Test func testProductFetchingFlow() async throws {

        let mockAPI = MockApiService()
        mockAPI.mockProductPage = .init(
            products: [
                Product.initTestData()
            ],
            currentPage: 1,
            pageSize: 24,
            totalResults: 70,
            pageCount: 3
        )

        let repository = ProductPageRepository(apiService: mockAPI)
        let useCase = FetchProductPageUseCase(repository: repository)
        let viewModel = ProductPageViewModel(fetchProductPageUseCase: useCase)

        await viewModel.fetchProducts()

        #expect(viewModel.products.count == 1)
        #expect(viewModel.errorMessage == nil)
    }
}
