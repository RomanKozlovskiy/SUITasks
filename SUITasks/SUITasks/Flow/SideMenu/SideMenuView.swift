//
//  SideMenuView.swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import SwiftUI

struct SideMenuView: View {
    private let sidebarWidth = UIScreen.main.bounds.size.width * 0.8
    @ObservedObject var viewModel = SideMenuViewModel()
    @Binding var isSideMenuOpened: Bool
    
    var body: some View {
        let drag = DragGesture()
            .onEnded { gesture in
                if gesture.translation.width < -100 {
                    withAnimation {
                        isSideMenuOpened.toggle()
                    }
                }
            }
        
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(.black.opacity(0.2))
            .opacity(isSideMenuOpened ? 1 : 0)
            .animation(.easeInOut, value: isSideMenuOpened)
            .onTapGesture {
                isSideMenuOpened.toggle()
            }
            
            content
                .gesture(drag)
        }
        .ignoresSafeArea(.all)
    }
    
    var content: some View {
        HStack {
            List {
                ForEach(viewModel.screens) { item in
                    Button("\(item.screens.title)") {
            
                    }
                    .padding()
                    .accessibilityIdentifier(item.screens.rawValue)
                }
                .listRowSeparator(.visible)
            }
            .listStyle(.plain)
            .padding([.top], 60)
            .background()
            .frame(width: sidebarWidth)
            .offset(x: isSideMenuOpened ? 0 : -sidebarWidth)
            .animation(.default, value: isSideMenuOpened)
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
