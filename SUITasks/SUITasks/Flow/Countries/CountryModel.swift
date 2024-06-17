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

struct CountryModel: Codable, Identifiable {
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
}

struct CountryInfo: Codable {
    let images: [String]
    let flag: String
}

// MARK: - Mock Request

var countryResponse: CountryResponse = load("Countries.json")


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }


    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }


    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
