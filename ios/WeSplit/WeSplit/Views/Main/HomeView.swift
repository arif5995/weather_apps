//
//  HomeView.swift
//  WeSplit
//
//  Created by Muhammad Arif on 14/12/24.
//

import SwiftUI
import BottomSheet



struct HomeView: View {
    //    @State var isPresented = true
    //    @State var selectedDetent: BottomSheet.PresentationDetent = BottomSheet.PresentationDetent.medium
    @StateObject var sheetCustom = SheetCustom()
    //    @State var bottomSheetTranslation = BottomSheet.PresentationDetent.medium.size
    @State var hasDragged: Bool = false
    @State private var selection = 0
    
    var bottomSheetTranslationProrated:CGFloat {
        ((sheetCustom.bottomSheetTranslation == 0 ? 426 : sheetCustom.bottomSheetTranslation) - BottomSheet.PresentationDetent.medium.size) / (BottomSheet.PresentationDetent.large.size - BottomSheet.PresentationDetent.medium.size)
        
    }
    
    @ViewBuilder
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                let screenHigh = geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom
                let imageOffset = screenHigh + 50
                
                ZStack{
                    // MARK: Background Color
                    Color.background.ignoresSafeArea()
                    
                    // Mark: Background Image
                    Image("Background")
                        .resizable()
                        .ignoresSafeArea()
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    // Mark: House Image
                    Image("House")
                        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                        .padding(.top, 200)
                        .offset(y: -bottomSheetTranslationProrated * imageOffset)
                    
                    VStack(spacing: -10 * (1 - bottomSheetTranslationProrated)){
                        
                        Text("Montreal").font(.largeTitle).foregroundColor(.white)
                        VStack{
                            Text(attributeString)
                            
                            Text("H:24º   L:18º").font(.title3.weight(.semibold))
                                .opacity(1 - bottomSheetTranslationProrated).foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding(.top, 35)
                    .offset(y: -bottomSheetTranslationProrated * 46)
                    // MARK: Bottom Sheet
                    SheetUtils(isPresented: $sheetCustom.isPresented, onDrag: {
                        translation in
                        sheetCustom.bottomSheetTranslation = translation
                        //                        print(translation.formatted())
                        withAnimation(.easeInOut){
                            if sheetCustom.selectedDetent.size == BottomSheet.PresentationDetent.large.size{
                                hasDragged = true
                                selection = 0
                            }else{
                                hasDragged = false
                            }
                        }
                    }, selectedDetent: $sheetCustom.selectedDetent,
                               selection: $selection,
                               hasDragged: $hasDragged,
                               bottomSheetTranslation: $sheetCustom.bottomSheetTranslation,
                               sheetCustom: sheetCustom
                    ).onAppear{
                        print("Appear")
                        print(" \(sheetCustom.bottomSheetTranslation.formatted()) and \(sheetCustom.isPresented.description) and \(sheetCustom.selectedDetent.size.formatted())")
                        sheetCustom.selectedDetent = .height(426)
                        sheetCustom.isPresented = true
                        sheetCustom.bottomSheetTranslation = BottomSheet.PresentationDetent.height(426).size
                    }
                    
                    // MARK: Tab Bar
                    TabBar(action:{
                        sheetCustom.selectedDetent = .large
                    }, sheetCustom: sheetCustom).offset(y: hasDragged ? (bottomSheetTranslationProrated * 100) : 0)
                    
                    
                    
                }
                
            }
            .navigationBarHidden(true)
            
            
        }
        
    }
    
    private var attributeString: AttributedString{
        var string  = AttributedString("19º" + (hasDragged ? " | " : "\n ") + "Mostly Clear")
        if let temp = string.range(of: "19º"){
            string[temp].font = .system(size: (96 - (bottomSheetTranslationProrated * (90-25))), weight: hasDragged ? .semibold : .thin)
            string[temp].foregroundColor = hasDragged ? .gray : .white
        }
        
        if let pipe = string.range(of: " | "){
            string[pipe].font = .title3.weight(.semibold)
            string[pipe].foregroundColor = .secondary.opacity(bottomSheetTranslationProrated)
        }
        
        if let weather = string.range(of: "Mostly Clear"){
            string[weather].font = .title3.weight(.semibold)
            string[weather].foregroundColor = .gray
        }
        
        return string
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    
}
