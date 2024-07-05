//
//  ContentCoordinator .swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import Foundation
import SwiftUI
import Stinsen

final class ContentCoordinator: NavigationCoordinatable {
    var stack = NavigationStack(initial: \ContentCoordinator.start)
    
    @Root var start = makeStart
    @Route(.push) var countries = makeCountries
    @Route(.push) var yandexMap = makeYandexMap
    
    @ViewBuilder func makeCountries() -> some View {
        CountriesView()
    }
    
    @ViewBuilder func makeYandexMap() -> some View {
        MapView()
    }
    
    @ViewBuilder func makeStart() -> some View {
        MainView()
    }
}
