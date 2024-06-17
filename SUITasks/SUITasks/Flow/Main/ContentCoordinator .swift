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
    
    @ViewBuilder func makeCountries() -> some View {
        CountriesView()
    }
    
    @ViewBuilder func makeStart() -> some View {
        MainView()
    }
}
