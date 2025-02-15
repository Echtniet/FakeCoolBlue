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

    var mockProductPage: ProductPageDTO!
    var shouldThrowError = false

    func execute(for pageNumber: Int, search criteria: String?) async throws -> FakeCoolBlue.ProductPage {
        if shouldThrowError {
            throw NSError(domain: "FetchPageError", code: 1)
        }
        return ProductPage(dto: mockProductPage)
    }
}

struct ProductPageViewModelTests {

    @Test func testFetchProductPageSuccess() async throws {
        let mockUseCase = MockFetchProductPageUseCase()
        mockUseCase.mockProductPage = .init(
            products: [
                ProductDTO.initTestData()
            ],
            currentPage: 1,
            pageSize: 24,
            totalResults: 70,
            pageCount: 3
        )

        let filterAvailableProductsUseCase = FilterAvailableProductsUseCase()
        let filterNextDayDeliveryUseCase = FilterNextDayDeliveryUseCase()
        let viewModel = ProductPageViewModel(
            fetchProductPageUseCase: mockUseCase,
            filterAvailableProductsUseCase: filterAvailableProductsUseCase,
            filterNextAvailableProductsUseCase: filterNextDayDeliveryUseCase
        )

        await viewModel.fetchProducts()

        #expect(viewModel.products.count == 1)
        #expect(viewModel.errorMessage == nil)
    }

    @Test func testFetchProductPageFailure() async throws {
        let mockUseCase = MockFetchProductPageUseCase()
        mockUseCase.shouldThrowError = true

        let filterAvailableProductsUseCase = FilterAvailableProductsUseCase()
        let filterNextDayDeliveryUseCase = FilterNextDayDeliveryUseCase()
        let viewModel = ProductPageViewModel(
            fetchProductPageUseCase: mockUseCase,
            filterAvailableProductsUseCase: filterAvailableProductsUseCase,
            filterNextAvailableProductsUseCase: filterNextDayDeliveryUseCase
        )

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

extension ProductDTO {

    static func initTestData() -> ProductDTO {
        ProductDTO(
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
