//
//  CountriesViewModel.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import Foundation

class CountriesViewModel: ObservableObject {
    @Published var countries = countryResponse.countries
}
