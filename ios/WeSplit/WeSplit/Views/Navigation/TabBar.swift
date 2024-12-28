//
//  TabBar.swift
//  WeSplit
//
//  Created by Muhammad Arif on 15/12/24.
//

import SwiftUI
import BottomSheet

struct TabBar: View {
    var action: ()-> Void
    @ObservedObject var sheetCustom: SheetCustom
    
    var body: some View {
        ZStack{
            // MARK: Arc Shape
            Arc()
                .fill(Color.tabBarBackground)
                .frame(height: 88)
                .overlay{
                    // MARK: Arc Border
                    Arc()
                        .stroke(Color.tabBarBrder, lineWidth: 0.5)
                }
            // MARK: Tap Itemns
            HStack{
                // MARK: Expand Button
                Button{
                    action()
                }label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                
                // MARK: Navigation Button
                NavigationLink{
                    WeatherView(sheetCustom: sheetCustom)
                }label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 30, leading: 32, bottom: 30, trailing: 32))
        }
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
        .ignoresSafeArea()
    }
}

#Preview {
    TabBar(action: {}, sheetCustom: SheetCustom())
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}
