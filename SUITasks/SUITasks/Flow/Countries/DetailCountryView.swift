//
//  DetailCountryView.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import SwiftUI

struct DetailCountryView: View {
    private var countryModel: CountryModel
    @State private var selectedImage: String = ""
    
    init(countryModel: CountryModel) {
        self.countryModel = countryModel
    }
    
    var body: some View {
        VStack {
            
            ScrollView {
                
                TabView(selection: $selectedImage) {
                    if countryModel.countryInfo.images.isEmpty {
                        Image(systemName: "photo")
                            .imageScale(.large)
                            .font(.title)
                            .foregroundStyle(.orange)
                    } else {
                        ForEach(countryModel.countryInfo.images, id: \.self) { imageUrl in
                            AsyncImage(url: imageUrl)
                        }
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 350)
            }
            .frame(height: 350)
            
            ScrollView {
                countryDescription
                    .padding(.bottom, 20)
            }
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    var countryDescription: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                Text(countryModel.name)
                    .font(.largeTitle)
                
                HStack {
                    
                    Image(systemName: "star")
                        .foregroundStyle(.orange)
                        .font(.title)
                    Text("Capital")
                        .font(.title2)
                    Spacer()
                    Text(countryModel.capital)
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
                .frame(height: 50)
                
                HStack {
                    
                    Image(systemName: "face.smiling")
                        .foregroundStyle(.orange)
                        .font(.title)
                    Text("Population")
                        .font(.title2)
                    Spacer()
                    Text("\(countryModel.population)")
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
                .frame(height: 50)
                
                HStack {
                    
                    Image(systemName: "globe.americas.fill")
                        .foregroundStyle(.orange)
                        .font(.title)
                    Text("Continent")
                        .font(.title2)
                    Spacer()
                    Text(countryModel.continent)
                        .font(.title2)
                        .foregroundStyle(.gray)
                }
                .frame(height: 50)
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("About")
                    .font(.title3).bold()
                Text(countryModel.description)
            }
            .padding(.horizontal)
        }
    }
}
