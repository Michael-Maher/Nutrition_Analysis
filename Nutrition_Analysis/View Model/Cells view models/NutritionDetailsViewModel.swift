//
//  NutritionDetailsViewModel.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/15/21.
//

import Foundation


class NutritionDetailsViewModel {
    var nutrition: CustomNutritionModel?
    
    var title: String {
        return nutrition?.nutrition?.label ?? "-"
    }
    
    var nutritionValue: String {
        return String(format: "%.2f", nutrition?.nutrition?.quantity ?? 0) + " \(nutrition?.nutrition?.unit ?? "")"
    }
    
    var percentage: String {
        return String(format: "%.2f",nutrition?.percentage ?? 0) + " %"
    }
    
    init(nutrition: CustomNutritionModel) {
        self.nutrition = nutrition
    }
}
