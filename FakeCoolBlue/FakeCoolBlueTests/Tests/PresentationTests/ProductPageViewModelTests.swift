//
//  ProductPageViewModelTests.swift
//  FakeCoolBlue
//
//  Created by Clinton on 10/02/2025.
//

import Testing
@testable import FakeCoolBlue
import Foundation

class MockFetchProductPageUseCase: FetchProductPageUseCaseProtocol {

    var mockProductPage: ProductPage!
    var shouldThrowError = false

    func execute(for pageNumber: Int, search criteria: String?) async throws -> FakeCoolBlue.ProductPage {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return mockProductPage
    }
}

struct ProductPageViewModelTests {

    @Test func testFetchProductPageSuccess() async throws {
        let mockUseCase = MockFetchProductPageUseCase()
        mockUseCase.mockProductPage = .init(
            products: [
                Product.initTestData()
            ],
            currentPage: 1,
            pageSize: 24,
            totalResults: 70,
            pageCount: 3
        )

        let viewModel = ProductPageViewModel(fetchProductPageUseCase: mockUseCase)
        await viewModel.fetchProducts()

        #expect(viewModel.products.count == 1)
        #expect(viewModel.errorMessage == nil)
    }

    @Test func testFetchProductPageFailure() async throws {
        let mockUseCase = MockFetchProductPageUseCase()
        mockUseCase.shouldThrowError = true
        
        let viewModel = ProductPageViewModel(fetchProductPageUseCase: mockUseCase)
        await viewModel.fetchProducts()

        #expect(viewModel.errorMessage != nil)
    }
}

extension Product {

    static func initTestData() -> Product {
        Product(
            productId: 832743,
            productName: "Test Product",
            reviewInformation: .init(
                reviews: [],
                reviewSummary: .init(
                    reviewAverage: 7.5,
                    reviewCount: 65
                )
            ),
            usps: [],
            availabilityState: 1,
            salesPriceIncVat: 643.95,
            productImage: "someurl",
            coolbluesChoiceInformationTitle: nil,
            promoIcon: nil,
            nextDayDelivery: false
        )
    }
}
