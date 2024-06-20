//
//  RealmManager .swift
//  SUITasks
//
//  Created by user on 19.06.2024.
//

import SwiftUI
import RealmSwift

final class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    
    init() {
        openRealm()
    }
    
    private func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            Realm.Configuration.defaultConfiguration = config
            self.localRealm = try Realm()
        } catch {
            print("Error opening Realm - \(error.localizedDescription)")
        }
    }
    
    func addCountry(_ country: CountryModel) {
        guard let localRealm else {
            return
        }
        
        let countryRealmModel: CountryRealmModel = CountryRealmModel()
        countryRealmModel.name = country.name
        countryRealmModel.continent = country.continent
        countryRealmModel.capital = country.capital
        countryRealmModel.population = country.population
        countryRealmModel.descriptionSmall = country.descriptionSmall
        countryRealmModel.descriptionLarge = country.description
        countryRealmModel.image = country.image
        countryRealmModel.images.append(objectsIn: country.countryInfo.images)
        countryRealmModel.flag = country.countryInfo.flag
        
        do {
            try localRealm.write {
                localRealm.add(countryRealmModel)
                print("Added country - \(countryRealmModel.name)")
            }
        } catch {
            print("Error adding country to Realm")
        }
    }
    
    func getCountries() -> [CountryModel] {
        guard let localRealm else {
            return []
        }
        
        let countriesRealm = localRealm.objects(CountryRealmModel.self)
        
        let countries: [CountryModel] = countriesRealm.compactMap { countryRealm in
            let country = CountryModel(
                name: countryRealm.name,
                continent: countryRealm.continent,
                capital: countryRealm.capital,
                population: countryRealm.population,
                descriptionSmall: countryRealm.descriptionSmall,
                description: countryRealm.descriptionLarge,
                image: countryRealm.image,
                countryInfo: CountryInfo(images: countryRealm.images.toArray(), flag: countryRealm.flag))
            
            return country
        }
        return countries
    }
}
