//
//  PromoIcon.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

struct PromoIcon: Codable, Hashable {
    let text: String
    let type: String

    init(
        text: String = "",
        type: String = ""
    ) {
        self.text = text
        self.type = type
    }

    init(dto: PromoIconDTO) {
        self.text = dto.text
        self.type = dto.type
    }
}
