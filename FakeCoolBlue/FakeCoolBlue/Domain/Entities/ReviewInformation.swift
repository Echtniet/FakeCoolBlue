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
    }
}
