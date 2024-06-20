//
//  CountriesModel.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import Foundation

struct CountryResponse: Codable {
    let next: String
    let countries: [CountryModel]
}

struct CountryModel: Codable, Identifiable, Equatable, Hashable {
    var id: String {
        self.name
    }
    
    let name: String
    let continent: String
    let capital: String
    let population: Int
    let descriptionSmall: String
    let description: String
    let image: String
    let countryInfo: CountryInfo
    
    enum CodingKeys: String, CodingKey {
        case name, continent, capital, population
        case descriptionSmall = "description_small"
        case description, image
        case countryInfo = "country_info"
    }
    
    static func == (lhs: CountryModel, rhs: CountryModel) -> Bool {
        lhs.id == rhs.id
    }
}

struct CountryInfo: Codable, Hashable {
    let images: [String]
    let flag: String
}
