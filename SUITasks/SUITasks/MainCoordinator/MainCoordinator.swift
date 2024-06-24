//
//  MainCoordinator.swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import Foundation
import SwiftUI
import Stinsen

final class MainCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<MainCoordinator>
    
    @Root var content = makeContent
    
    init() {
        stack = NavigationStack(initial: \MainCoordinator.content)
    }
    
    func makeContent() -> NavigationViewCoordinator<ContentCoordinator> {
        NavigationViewCoordinator(ContentCoordinator())
    }
}
