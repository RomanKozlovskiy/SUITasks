//
//  CountryCellView.swift
//  SUITasks
//
//  Created by user on 17.06.2024.
//

import SwiftUI

struct CountryCellView: View {
    let countryModel: CountryModel
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Image("argentina")
                    .resizable()
                    .frame(width: 70, height: 50)
                
                VStack {
                    
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

#Preview {
    CountryCellView(countryModel: countryResponse.countries[0])
}
