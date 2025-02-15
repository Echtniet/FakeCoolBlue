//
//  ReviewInformation.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

struct ReviewInformation: Codable, Hashable {
    let reviews: [String]
    let reviewSummary: ReviewSummary

    struct ReviewSummary: Codable, Hashable {
        let reviewAverage: Double
        let reviewCount: Int

        init(
            reviewAverage: Double,
            reviewCount: Int
        ) {
            self.reviewAverage = reviewAverage
            self.reviewCount = reviewCount
        }

        init(dto: ReviewInformationDTO.ReviewSummaryDTO) {
            self.reviewAverage = dto.reviewAverage
            self.reviewCount = dto.reviewCount
        }
    }

    init(
        reviews: [String],
        reviewSummary: ReviewSummary
    ) {
        self.reviews = reviews
        self.reviewSummary = reviewSummary
    }

    init(dto: ReviewInformationDTO) {
        self.reviews = dto.reviews
        self.reviewSummary = ReviewSummary(dto: dto.reviewSummary)
    }
}
