//
//  SheetCustom.swift
//  WeSplit
//
//  Created by Muhammad Arif on 26/12/24.
//

import Foundation
import BottomSheet

class SheetCustom: ObservableObject{
    @Published var selectedDetent: BottomSheet.PresentationDetent = .medium
    @Published var bottomSheetTranslation: CGFloat = BottomSheet.PresentationDetent.medium.size
    @Published var isPresented = true
}
