//
//  ReviewInformationDTO.swift
//  FakeCoolBlue
//
//  Created by Clinton on 14/02/2025.
//

import Foundation

struct ReviewInformationDTO: Codable, Hashable {
    let reviews: [String]
    let reviewSummary: ReviewSummaryDTO

    struct ReviewSummaryDTO: Codable, Hashable {
        let reviewAverage: Double
        let reviewCount: Int
    }
}
