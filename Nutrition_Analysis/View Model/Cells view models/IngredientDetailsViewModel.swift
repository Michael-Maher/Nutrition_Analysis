//
//  IngredientDetailsViewModel.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/5/21.
//

import Foundation
import RxSwift

class IngredientDetailsViewModel: NSObject {
    
    var ingr: Ingredients?
//    var isHeaderCell: Bool {
//        return ingr?.text?.isEmpty ?? true
//    }
    
    var parsedIngr: Ingredient? {
        return ingr?.parsed?.first
    }
    
    var qty: String {
        return String(parsedIngr?.quantity ?? 0)
    }
    
    var unit: String {
        return parsedIngr?.measure ?? "-"
    }
    
    var food: String {
        return parsedIngr?.foodMatch ?? "-"
    }
    
    var ingredientCalories: GenericMeasureModel? {
        return parsedIngr?.nutrients?.ENERC_KCAL
    }
    
    var calories: String {
        return String(format: "%.1f", ingredientCalories?.quantity ?? 0) + " \(ingredientCalories?.unit ?? "")"
    }
    
    var wright: String {
        return String(format: "%.1f", parsedIngr?.weight ?? 0)
    }
    
    
    init(ingr: Ingredients?) {
        self.ingr = ingr
    }
    
}
