//
//  CountriesViewModel.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import Foundation
import Combine

final class CountriesViewModel: ObservableObject {
    @Published var countries: [CountryModel] = []
    @Published var isLoading: Bool = false
    
    var nextCountries: String?
    
    private var cansellables = Set<AnyCancellable>()
    
    func fetchCountries(_ next: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json") {
        guard let url = URL(string: next) else {
            return // MARK: - Handle
        }
        isLoading = true
        URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: CountryResponse.self, decoder: JSONDecoder())
            .sink { complete in
                switch complete {
                case .finished: break
                    // MARK: - Handle
                case .failure(_): break
                    // MARK: - Handle
                }
            } receiveValue: { [weak self] countryResponse in
                self?.countries.append(contentsOf: countryResponse.countries)
                self?.nextCountries = countryResponse.next
                self?.isLoading = false
            }.store(in: &cansellables)
    }
    
    func refreshCountries() {
        countries = []
        fetchCountries()
    }
}
