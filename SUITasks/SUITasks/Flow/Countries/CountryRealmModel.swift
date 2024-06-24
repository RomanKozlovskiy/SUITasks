//
//  CountryRealmModel.swift
//  SUITasks
//
//  Created by user on 18.06.2024.
//

import SwiftUI
import RealmSwift

class CountryRealmModel: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var name: String = ""
    @Persisted var continent: String = ""
    @Persisted var capital: String = ""
    @Persisted var population: Int = 0
    @Persisted var descriptionSmall: String = ""
    @Persisted var descriptionLarge: String = ""
    @Persisted var image: String = ""
    @Persisted var images = RealmSwift.List<String>()
    @Persisted var flag: String = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
}

extension RealmCollection {
    func toArray<T>() -> [T] {
        return self.compactMap { $0 as? T}
    }
}
