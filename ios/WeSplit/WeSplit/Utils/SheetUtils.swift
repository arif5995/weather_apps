//
//  SheetUtils.swift
//  WeSplit
//
//  Created by Muhammad Arif on 25/12/24.
//

import SwiftUI
import BottomSheet

struct SheetUtils: View {
    @Binding var isPresented: Bool
    var onDrag: (CGFloat)-> Void
    @Binding var selectedDetent: BottomSheet.PresentationDetent
    @Binding var selection: Int
    @Binding var hasDragged: Bool
    @Binding var bottomSheetTranslation:CGFloat
    
    @ObservedObject var sheetCustom: SheetCustom
    
    var bottomSheetTranslationProrated:CGFloat {
        ((bottomSheetTranslation == 0 ? 426 : bottomSheetTranslation)  - BottomSheet.PresentationDetent.medium.size) / (BottomSheet.PresentationDetent.large.size - BottomSheet.PresentationDetent.medium.size)
    
    }
    var body: some View {
        HStack{}.sheetPlus(
            isPresented: $isPresented,
                background: (
                    
                    ForecastView(bottomSheetTranslationProrated: bottomSheetTranslationProrated)
                
                ),onDrag: { translation in
                   onDrag(translation)
                },header:{
                    // Mark: Segmented Control
                    SegmentedControl(selection: $selection)

                },main: {
                    ForeCastFill(bottomSheetTranslationProrated: bottomSheetTranslationProrated,
                                 hasDrag: hasDragged,
                                 selection: $selection)
                        .presentationDetentsPlus(
                            [.height(0),  .medium, .large],
                            selection: $selectedDetent
                        )
                        .presentationDragIndicatorPlus(.visible)
                    
                }
        ).onAppear{
            print("Appear")
            sheetCustom.selectedDetent = .medium
            sheetCustom.isPresented = true
            sheetCustom.bottomSheetTranslation = BottomSheet.PresentationDetent.medium.size
        }
    }
}

#Preview {
    SheetUtils(isPresented: .constant(true), onDrag: {_ in }, selectedDetent: .constant(.medium), selection: .constant(0), hasDragged: .constant(false), bottomSheetTranslation: .constant(BottomSheet.PresentationDetent.medium.size), sheetCustom: SheetCustom())
}


//bottomSheetTranslation = translation
//withAnimation(.easeInOut){
//    if selectedDetent.size == BottomSheet.PresentationDetent.large.size{
//        hasDragged = true
//    }else{
//        hasDragged = false
//    }
//}
