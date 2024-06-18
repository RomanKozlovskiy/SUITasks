//
//  CountryCellView.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import SwiftUI

struct CountryCellView: View {
    private let countryModel: CountryModel
    
    init(countryModel: CountryModel) {
        self.countryModel = countryModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                AsyncImage(url: countryModel.countryInfo.flag)
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 54, maxHeight: 36)
                
                VStack(alignment: .leading) {
                    
                    Text(countryModel.name)
                        .font(.title2)
                    
                    Text(countryModel.capital)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                }
            }
            
            Text(countryModel.descriptionSmall)
        }
    }
}

struct AsyncImage: View {
    @StateObject var loader = ImageLoader()
    
    private let url: String
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        Group {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                Image(systemName: "photo")
                    .imageScale(.large)
                    .font(.title)
                    .foregroundStyle(.orange)
            }
        }
        .onAppear {
            loader.fetch(from: url)
        }
    }
}
