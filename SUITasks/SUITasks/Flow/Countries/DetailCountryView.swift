//
//  DetailCountryView.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import SwiftUI

struct DetailCountryView: View {
    var countryModel: CountryModel
    
    let images = ["argentina", "vietnam"]
    var body: some View {
        
        VStack {
            
            ScrollView {
                
                TabView {
                    
                    ForEach(images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            
                    }
                }
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .frame(height: 240)
               
            }
            .frame(height: 240)
 
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

#Preview {
    DetailCountryView(countryModel: countryResponse.countries[0])
}



