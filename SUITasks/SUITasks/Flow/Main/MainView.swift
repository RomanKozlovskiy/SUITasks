//
//  MainView.swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var isSideMenuOpened = false
    
    var body: some View {
        let drag = DragGesture()
            .onEnded { gesture in
                if gesture.location.x < 200 && gesture.translation.width > 30 {
                    isSideMenuOpened.toggle()
                }
            }
        
        ZStack {
            NavigationView {
                Image(systemName: "homekit")
                    .imageScale(.large)
                
                    .font(.largeTitle)
                    .foregroundStyle(.blue)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            button
                        }
                    }
                    .navigationTitle("Home")
                    .navigationBarTitleDisplayMode(.inline)
            }
            SideMenuView(isSideMenuOpened: $isSideMenuOpened)
        }
        .gesture(drag)
    }
    
    @ViewBuilder var button: some View {
        Button("", systemImage: "line.3.horizontal") {
            isSideMenuOpened.toggle()
        }
    }
}

#Preview {
    MainView()
}
