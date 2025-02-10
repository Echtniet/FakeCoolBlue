//
//  FakeCoolBlueTests.swift
//  FakeCoolBlueTests
//
//  Created by Clinton on 05/02/2025.
//

import Testing
@testable import FakeCoolBlue
import Foundation

class MockProductPageRepository: ProductPageRepositoryProtocol {

    var mockProductPage: ProductPage!
    var shouldThrowError: Bool = false

    func fetchProductPage(for pageNumber: Int, search criteria: String?) async throws -> FakeCoolBlue.ProductPage {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return mockProductPage
    }


}

struct FetchProductPageUseCaseTests {

    @Test func testFetchProductPageSuccess() async throws {
        let mockRepo = MockProductPageRepository()
        mockRepo.mockProductPage = .init(
            products: [],
            currentPage: 1,
            pageSize: 24,
            totalResults: 70,
            pageCount: 3
        )

        let useCase = FetchProductPageUseCase(repository: mockRepo)
        let productPage = try await useCase.execute(for: 1, search: nil)

        #expect(productPage.currentPage == 1)
    }

    @Test func testFetchProductPageFailure() async throws {
        let mockRepo = MockProductPageRepository()
        mockRepo.shouldThrowError = true

        let useCase = FetchProductPageUseCase(repository: mockRepo)
        
        await #expect(throws: NSError.self) {
            _ = try await useCase.execute(for: 1, search: nil)
        }
    }
}
