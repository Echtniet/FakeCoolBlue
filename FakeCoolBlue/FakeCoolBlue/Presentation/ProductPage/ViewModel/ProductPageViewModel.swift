//
//  ProductPageViewModel.swift
//  FakeCoolBlue
//
//  Created by Clinton on 06/02/2025.
//

import SwiftUI
import Foundation
import Observation
import Combine

@Observable
class ProductPageViewModel {

    var selectedProduct: Product? = nil
    var products: [Product] = []
    var currentPage: Int = 0
    var pageSize: Int = 0
    var totalResults: Int = 0
    var pageCount: Int = -1
    var searchCriteria: String = ""
    var newSearchCriteria: Bool = false
    var isLoading: Bool = false
    var errorMessage: String?

    private let fetchProductPageUseCase: FetchProductPageUseCaseProtocol

    init(fetchProductPageUseCase: FetchProductPageUseCaseProtocol) {
        self.fetchProductPageUseCase = fetchProductPageUseCase
    }

    func fetchProducts() async {
        isLoading = true
        errorMessage = nil

        do {

            guard shouldFetch() else { return }
            let productPage = try await fetchProductPageUseCase.execute(for: currentPage + 1, search: searchCriteria)
            products.append(contentsOf: productPage.products)
            currentPage = productPage.currentPage
            pageSize = productPage.pageSize
            totalResults = productPage.totalResults
            pageCount = productPage.pageCount

        } catch {
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    func onSearchFetch() async {
        currentPage = 0
        products.removeAll()
        await fetchProducts()
    }

    private func shouldFetch() -> Bool {
        currentPage < pageCount || pageCount == -1
    }

}
