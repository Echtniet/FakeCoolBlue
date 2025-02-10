//
//  ProductsPageView.swift
//  FakeCoolBlue
//
//  Created by Clinton on 06/02/2025.
//

import SwiftUI

struct ProductPageView: View {

    @Namespace private var animation
    @State private var viewModel: ProductPageViewModel

    init() {
        let apiService = APIService()
        let repository = ProductPageRepository(apiService: apiService)
        let useCase = FetchProductPageUseCase(repository: repository)
        viewModel = .init(fetchProductPageUseCase: useCase)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    SearchBoxView(text: $viewModel.searchCriteria, animation: animation)
                    if viewModel.isLoading && viewModel.products.isEmpty {

                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                    } else {
                        List(viewModel.products, id: \.self) { product in
                            ProductView(
                                animation: animation,
                                product: product
                            ) {
                                withAnimation(.spring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5)) {
                                    viewModel.selectedProduct = product
                                } completion: {
                                    print("Completed")
                                }
                            }
                            .listRowSeparator(.hidden)
                            .onAppear {
                                if product == viewModel.products.last {
                                    Task {
                                        await viewModel.fetchProducts()
                                    }
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                .navigationTitle("Products")
                .navigationBarTitleDisplayMode(.inline)
                if let selectedProduct = viewModel.selectedProduct {
                    DetailedProductView(
                        animation: animation,
                        product: selectedProduct
                    ) {
                        withAnimation(.spring(response: 0.7, dampingFraction: 1, blendDuration: 0.5)) {
                            viewModel.selectedProduct = nil
                        }
                    }
                }
            }
        }
        .onChange(of: viewModel.searchCriteria) {
            Task {
                await viewModel.onSearchFetch()
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .task {
            await viewModel.fetchProducts()
        }
    }
}
