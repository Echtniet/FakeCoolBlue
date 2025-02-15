//
//  APIService.FetchProductPage.swift
//  FakeCoolBlue
//
//  Created by Clinton on 05/02/2025.
//

import Foundation

extension APIService {
    func fetchProductPage(for pageNumber: Int, search criteria: String?) async throws -> ProductPageDTO {
        let urlString = "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/mobile-assignment/search?quer%20y=\(criteria ?? "")&page=\(pageNumber)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ProductPageDTO.self, from: data)
    }
}
