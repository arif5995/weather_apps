//
//  WeatherView.swift
//  WeSplit
//
//  Created by Muhammad Arif on 19/12/24.
//

import SwiftUI

struct WeatherView: View {
    @State private var searchText = ""
    @ObservedObject var sheetCustom: SheetCustom
    
    var searchResults: [Forecast] {
        if searchText.isEmpty {
            return Forecast.cities
        } else {
            return Forecast.cities.filter { $0.location.contains(searchText) }
        }
    }
    
    var body: some View {
        ZStack{
            // MARK: Background
            Color.background
                .ignoresSafeArea()
            
            // MARK: Weather Widgets
            ScrollView(showsIndicators: false, content: {
                VStack(spacing: 20, content: {
                    ForEach(searchResults, content: {
                        forecast in WeatherWidget(forecast: forecast)
                    })
                })
            })
            .safeAreaInset(edge: .top, content: {
                EmptyView().frame(height: 110)
            })
            
        }
        .overlay{
            // MARK: Navigation Bar
            NavigationBar(searchText: $searchText, sheetCustom: sheetCustom)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    WeatherView(sheetCustom: SheetCustom())
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
