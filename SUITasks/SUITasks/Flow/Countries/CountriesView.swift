//
//  Countries.swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import SwiftUI

struct CountriesView: View {
    @ObservedObject var viewModel = CountriesViewModel()
    
    var body: some View {
        List {
            
            ForEach(viewModel.countries) { country in
                
                NavigationLink {
                    DetailCountryView(countryModel: country)
                } label: {
                    CountryCellView(countryModel: country)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Countries")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            // update request
        }
    }
}

#Preview {
    CountriesView()
}
