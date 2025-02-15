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
    var filteredProducts: [Product] = []
    var currentPage: Int = 0
    var pageSize: Int = 0
    var totalResults: Int = 0
    var pageCount: Int = -1
    var searchCriteria: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    var showOnlyAvailable = false
    var showNextDayDeliveryOnly = false

    var searchTask: Task<Void, Never>?

    @ObservationIgnored var searchTextSubject = CurrentValueSubject<String, Never>("")
    @ObservationIgnored var cancellables: Set<AnyCancellable> = []

    private let fetchProductPageUseCase: FetchProductPageUseCaseProtocol
    private let filterAvailableProductsUseCase: FilterAvailableProductsUseCaseProtocol
    private let filterNextAvailableProductsUseCase: FilterNextDayDeliveryUseCaseProtocol

    init(
        fetchProductPageUseCase: FetchProductPageUseCaseProtocol,
        filterAvailableProductsUseCase: FilterAvailableProductsUseCaseProtocol,
        filterNextAvailableProductsUseCase: FilterNextDayDeliveryUseCaseProtocol
    ) {
        self.fetchProductPageUseCase = fetchProductPageUseCase
        self.filterAvailableProductsUseCase = filterAvailableProductsUseCase
        self.filterNextAvailableProductsUseCase = filterNextAvailableProductsUseCase
        setupDebouncedSearchFetch()
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
//            TODO: proper error handling
            errorMessage = "Error: \(error.localizedDescription)"
        }

        isLoading = false
    }

    private func setupDebouncedSearchFetch() {
        searchTextSubject
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.searchTask?.cancel()
                self?.searchTask = self?.createSearchTask(text)
            }
            .store(in: &cancellables)
    }

    private func createSearchTask(_ text: String) -> Task<Void, Never> {
        Task { @MainActor in
            await onSearchFetch()
        }
    }

    private func onSearchFetch() async {
//      TODO: Debounce search fetch
        currentPage = 0
        products.removeAll()
        await fetchProducts()
    }

    private func shouldFetch() -> Bool {
        currentPage < pageCount || pageCount == -1
    }

    func applyFilter() {
        var tempProducts = products

        if showOnlyAvailable {
            tempProducts = filterAvailableProductsUseCase.execute(products: tempProducts)
        }
        if showNextDayDeliveryOnly {
            tempProducts = filterNextAvailableProductsUseCase.execute(products: tempProducts)
        }

        filteredProducts = tempProducts
    }
}
