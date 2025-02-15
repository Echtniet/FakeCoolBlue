//
//  FilerAvilableProductsUseCase.swift
//  FakeCoolBlue
//
//  Created by Clinton on 14/02/2025.
//

import Foundation

protocol FilterAvailableProductsUseCaseProtocol {
    func execute(products: [Product]) -> [Product]
}

final class FilterAvailableProductsUseCase: FilterAvailableProductsUseCaseProtocol {
    func execute(products: [Product]) -> [Product] {
        return products.filter { $0.availabilityState == 1}
    }
}
