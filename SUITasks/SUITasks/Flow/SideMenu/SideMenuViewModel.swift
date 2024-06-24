//
//  SideMenuViewModel.swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import Foundation

enum Screens: String {
    case countryList
    case task2
    case task3
    
    var title: String {
        switch self {
            
        case .countryList:
            "Countries"
        case .task2:
            "Task 2"
        case .task3:
            "Task 3"
        }
    }
}

class SideMenuViewModel: ObservableObject {
    @Published var screens: [SideMenuItemModel] = [SideMenuItemModel(id: 0, screens: .countryList),
                                                   SideMenuItemModel(id: 1, screens: .task2),
                                                   SideMenuItemModel(id: 2, screens: .task3)]
}
