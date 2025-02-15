//
//  Product.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

// TODO: create productDTO
struct Product: Codable, Hashable {
    let productId: Int
    let productName: String
    let reviewInformation: ReviewInformation
    let usps: [String]
    let availabilityState: Int
    let salesPriceIncVat: Double
    let productImage: String
    let coolbluesChoiceInformationTitle: String?
    let promoIcon: PromoIcon?
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

    init(
        productId: Int,
        productName: String,
        reviewInformation: ReviewInformation,
        usps: [String],
        availabilityState: Int,
        salesPriceIncVat: Double,
        productImage: String,
        coolbluesChoiceInformationTitle: String?,
        promoIcon: PromoIcon?,
        nextDayDelivery: Bool
    ) {
        self.productId = productId
        self.productName = productName
        self.reviewInformation = reviewInformation
        self.usps = usps
        self.availabilityState = availabilityState
        self.salesPriceIncVat = salesPriceIncVat
        self.productImage = productImage
        self.coolbluesChoiceInformationTitle = coolbluesChoiceInformationTitle
        self.promoIcon = promoIcon
        self.nextDayDelivery = nextDayDelivery
    }

    init(dto: ProductDTO) {
        self.productId = dto.productId
        self.productName = dto.productName
        self.reviewInformation = ReviewInformation(dto: dto.reviewInformation)
        self.usps = dto.usps
        self.availabilityState = dto.availabilityState
        self.salesPriceIncVat = dto.salesPriceIncVat
        self.productImage = dto.productImage
        self.coolbluesChoiceInformationTitle = dto.coolbluesChoiceInformationTitle
        if let promoIconDTO = dto.promoIcon {
            self.promoIcon = PromoIcon(dto: promoIconDTO)
        } else {
            self.promoIcon = nil
        }
        self.nextDayDelivery = dto.nextDayDelivery
    }
}
