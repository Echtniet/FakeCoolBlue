//
//  ProductDTO.swift
//  FakeCoolBlue
//
//  Created by Clinton on 14/02/2025.
//

import Foundation

struct ProductDTO: Codable, Hashable {
    let productId: Int
    let productName: String
    let reviewInformation: ReviewInformationDTO
    let usps: [String]
    let availabilityState: Int
    let salesPriceIncVat: Double
    let productImage: String
    let coolbluesChoiceInformationTitle: String?
    let promoIcon: PromoIconDTO?
    let nextDayDelivery: Bool

    enum CodingKeys: String, CodingKey {
        case productId
        case productName
        case reviewInformation
        case usps = "USPs"
        case availabilityState
        case salesPriceIncVat
        case productImage
        case coolbluesChoiceInformationTitle
        case promoIcon
        case nextDayDelivery
    }
}
