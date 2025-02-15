//
//  FilterNextDayDeliveryUseCase.swift
//  FakeCoolBlue
//
//  Created by Clinton on 14/02/2025.
//

import Foundation

protocol FilterNextDayDeliveryUseCaseProtocol {
    func execute(products: [Product]) -> [Product]
}

final class FilterNextDayDeliveryUseCase: FilterNextDayDeliveryUseCaseProtocol {
    func execute(products: [Product]) -> [Product] {
        return products.filter { $0.nextDayDelivery }
    }
}
