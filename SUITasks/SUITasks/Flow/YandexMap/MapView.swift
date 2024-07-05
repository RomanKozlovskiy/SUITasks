//
//  YandexMapView.swift
//  SUITasks
//
//  Created by user on 25.06.2024.
//

import SwiftUI
import YandexMapsMobile

struct MapView: View {
    @ObservedObject var yandexMapsManager = YandexMapsManager()
    @State private var searchRequestText = ""
    @State private var isSearchState = false
    
    var body: some View {
        ZStack{
            YandexMapView()
                .ignoresSafeArea()
                .environmentObject(yandexMapsManager)
            
            VStack {
                Spacer()
                
                if isSearchState {
                    TextField("Search", text: $searchRequestText) {
                        yandexMapsManager.search(searchRequestText)
                        isSearchState = false
                    }
                    .padding()
                    .background(Color.green).opacity(0.7)
                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .continuous))
                    .padding(.horizontal, 16)
                    .frame(height: 40)
                }
                
                HStack {
                    Button {
                        isSearchState.toggle()
                    } label: {
                        Image(systemName: "location.magnifyingglass")
                            .resizable()
                            .foregroundStyle(.green)
                    }
                    .frame(width: 40,
                           height: 40)
                    
                    Spacer()
                    
                    Button {
                        yandexMapsManager.getCurrentLocation()
                    } label: {
                        Image(systemName: "location.circle")
                            .resizable()
                            .foregroundStyle(.green)
                    }
                    .frame(width: 40,
                           height: 40)
                }
                .padding(.horizontal, 16)
                .padding(.top, 30)
                .padding(.bottom, 60)
            }
        }.onAppear{
            yandexMapsManager.getInitialUserLocation()
        }
    }
}

struct YandexMapView: UIViewRepresentable {
    @EnvironmentObject var yandexMapsManager : YandexMapsManager
    func makeUIView(context: Context) -> YMKMapView {
        return yandexMapsManager.mapView
    }
    
    func updateUIView(_ mapView: YMKMapView, context: Context) {}
}

#Preview {
    MapView()
}
