//
//  Countries.swift
//  SUITasks
//
//  Created by user on 13.06.2024.
//

import SwiftUI

struct CountriesView: View {
    @ObservedObject private var viewModel = CountriesViewModel()
    @State private var didLoad = false
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.countries) { country in
                    NavigationLink {
                        DetailCountryView(countryModel: country)
                    } label: {
                        CountryCellView(countryModel: country)
                            .onAppear {
                                viewModel.checkForPagination(by: country)
                            }
                    }
                }
            }
            .listRowSeparator(.visible)
            .onAppear {
                if !didLoad {
                    didLoad = true
                    viewModel.fetchCountries()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                viewModel.refreshCountries()
            }
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(5)
            }
        }
    }
}

#Preview {
    CountriesView()
}
