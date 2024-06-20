//
//  CountriesViewModel.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import Foundation
import Combine
import Sentry

final class CountriesViewModel: ObservableObject {
    @Published var countries: [CountryModel] = []
    @Published var isLoading: Bool = false
    
    var nextCountries: String?
    
    private var cansellables = Set<AnyCancellable>()
    private let realmManager = RealmManager()

    func fetchCountries(_ next: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json") {
        guard let url = URL(string: next) else {
            SentrySDK.capture(message: "Incorrectly URL path: \(next)")
            return
        }
        
        isLoading = true
        URLSession.shared
            .dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: CountryResponse.self, decoder: JSONDecoder())
            .sink { complete in
                switch complete {
                case .finished:
                    SentrySDK.capture(message: "Successfully received CountryResponse")
                case let .failure(error):
                    SentrySDK.capture(error: error)
                }
            } receiveValue: { [weak self] countryResponse in
                self?.countries.append(contentsOf: countryResponse.countries)
                self?.nextCountries = countryResponse.next
                self?.validateForRealm(countryResponse.countries)
                self?.isLoading = false
            }.store(in: &cansellables)
    }
    
    func refreshCountries() {
        countries = []
        fetchCountries()
    }
    
    private func validateForRealm(_ countries: [CountryModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            
            let setResponseCountries = Set(countries)
            let realmCountries = Set(self.realmManager.getCountries())
            
            let unionCountries = setResponseCountries.subtracting(realmCountries).sorted { $0.name < $1.name }
            
            if !unionCountries.isEmpty {
                unionCountries.forEach { country in
                    self.realmManager.addCountry(country)
                }
            } else {
                print("This countries already added to Realm")
            }
        }
    }
}
