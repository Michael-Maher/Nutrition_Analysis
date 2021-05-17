//
//  NutritionViewModel.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/14/21.
//

import Foundation
import RxCocoa
import RxSwift


class NutritionViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let totalNutritionSubject = PublishSubject<[CustomNutritionModel]>()
    var totalNutrition: Driver<[CustomNutritionModel]> {
        return totalNutritionSubject
            .asDriver(onErrorJustReturn: [])
    }
    
    var analysis: Analysis?
    
    init(analysis: Analysis?) {
        self.analysis = analysis
    }
    
    
    func loadData() {
        
        var nutritions = [CustomNutritionModel]()
        // We check for each value to NOT add non existed values
        if let calories = analysis?.totalNutrients?.ENERC_KCAL {
            let caloriesPercentage = analysis?.totalDaily?.ENERC_KCAL?.quantity
            nutritions.append(CustomNutritionModel(nutrition: GenericMeasureModel(label: "Calories", quantity: calories.quantity, unit: calories.unit), percentage: caloriesPercentage))
        }
        if let fat = analysis?.totalNutrients?.FAT {
            let fatPercentage = analysis?.totalDaily?.FAT?.quantity
            nutritions.append(CustomNutritionModel(nutrition: fat, percentage: fatPercentage))
        }
        if let cholesterol = analysis?.totalNutrients?.CHOLE {
            let cholesterolPercentage = analysis?.totalDaily?.CHOLE?.quantity
            nutritions.append(CustomNutritionModel(nutrition: cholesterol, percentage: cholesterolPercentage))
        }
        if let sodium = analysis?.totalNutrients?.NA {
            let sodiumPercentage = analysis?.totalDaily?.NA?.quantity
            nutritions.append(CustomNutritionModel(nutrition: sodium, percentage: sodiumPercentage))
        }
        if let fiber = analysis?.totalNutrients?.FIBTG {
            let fiberPercentage = analysis?.totalDaily?.FIBTG?.quantity
            nutritions.append(CustomNutritionModel(nutrition: fiber, percentage: fiberPercentage))
        }
        
        if let sugar = analysis?.totalNutrients?.SUGAR {
            let sugarPercentage = analysis?.totalDaily?.SUGAR?.quantity
            nutritions.append(CustomNutritionModel(nutrition: sugar, percentage: sugarPercentage))
        }
        if let protein = analysis?.totalNutrients?.PROCNT {
            let proteinPercentage = analysis?.totalDaily?.PROCNT?.quantity
            nutritions.append(CustomNutritionModel(nutrition: protein, percentage: proteinPercentage))
        }
        if let vitamin = analysis?.totalNutrients?.VITD {
            let vitaminPercentage = analysis?.totalDaily?.VITD?.quantity
            nutritions.append(CustomNutritionModel(nutrition: vitamin, percentage: vitaminPercentage))
        }
        if let calcium = analysis?.totalNutrients?.CA {
            let calciumPercentage = analysis?.totalDaily?.CA?.quantity
            nutritions.append(CustomNutritionModel(nutrition: calcium, percentage: calciumPercentage))
        }
        if let iron = analysis?.totalNutrients?.FE {
            let ironPercentage = analysis?.totalDaily?.FE?.quantity
            nutritions.append(CustomNutritionModel(nutrition: iron, percentage: ironPercentage))
        }
        if let potassium = analysis?.totalNutrients?.K {
            let potassiumPercentage = analysis?.totalDaily?.K?.quantity
            nutritions.append(CustomNutritionModel(nutrition: potassium, percentage: potassiumPercentage))
        }
        totalNutritionSubject.onNext(nutritions)
    }
}
