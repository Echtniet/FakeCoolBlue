//
//  ProductPageRepositoryTests.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import Testing
@testable import FakeCoolBlue
import Foundation

class MockApiService: APIServiceProtocol {
    
    var mockProductPage: ProductPageDTO!
    var shouldThrowError: Bool = false

    func fetchProductPage(for pageNumber: Int, search criteria: String?) async throws -> ProductPageDTO {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return mockProductPage
    }
}

struct ProductPageRepositoryTests {
    
    @Test func testFetchProductPageSuccess() async throws {
        let mockAPI = MockApiService()
        mockAPI.mockProductPage = .init(
            products: [],
            currentPage: 1,
            pageSize: 24,
            totalResults: 70,
            pageCount: 3
        )

        let repository = ProductPageRepository(apiService: mockAPI)
        let productPage = try await repository.fetchProductPage(for: 1, search: nil)

        #expect(productPage.currentPage == 1)
    }

    @Test func testFetchProductPageFailure() async throws {
        let mockAPI = MockApiService()
        mockAPI.shouldThrowError = true

        let repository = ProductPageRepository(apiService: mockAPI)

        await #expect(throws: NSError.self) {
            _ = try await repository.fetchProductPage(for: 1, search: nil)
        }
    }
}
