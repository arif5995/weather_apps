//
//  ForeCastFill.swift
//  WeSplit
//
//  Created by Muhammad Arif on 17/12/24.
//

import SwiftUI

struct ForeCastFill: View {
    var bottomSheetTranslationProrated: CGFloat = 1
    var hasDrag: Bool = false
    @Binding var selection: Int
    
    var body: some View {
        // MARK: Forecast Cards
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                if selection == 0 {
                    ForEach(Forecast.hourly) { forecast in
                        ForecastCard(forecast: forecast, forecastPeriod: .hourly)
                    }
                    .transition(.offset(x: -430))
                } else {
                    ForEach(Forecast.daily) { forecast in
                        ForecastCard(forecast: forecast, forecastPeriod: .daily)
                    }
                    .transition(.offset(x: 430))
                }
            }
            .padding(.vertical, 40)
        }
        .padding(.horizontal, 20)
        
        // MARK: Forecast Widgets
        Image("Forecast Widgets")
            .opacity(hasDrag ? 1 : 0)
    }
}

#Preview {
    ForeCastFill(selection: .constant(0))
}
