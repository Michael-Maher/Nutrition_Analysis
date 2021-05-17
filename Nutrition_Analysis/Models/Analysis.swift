//
//  Analysis.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import Foundation
struct Analysis : Decodable {

	let calories : Int?
	let totalWeight : Double?
	let totalNutrients : Nutrients?
	let totalDaily : Nutrients?
	let ingredients : [Ingredients]?
}


struct Ingredients : Decodable {
    let text : String?
    let parsed : [Ingredient]?
}


struct Ingredient : Decodable {
    let quantity : Double?
    let measure : String?
    let foodMatch : String?
    let food : String?
    let foodId : String?
    let weight : Double?
    let retainedWeight : Double?
    let nutrients : Nutrients?
    let measureURI : String?
    let status : String?
}

struct Nutrients : Decodable {
    let ENERC_KCAL : GenericMeasureModel?
    let VITD : GenericMeasureModel?                    // Vitamin D
    let PROCNT : GenericMeasureModel?                  // Protein
    let CHOLE : GenericMeasureModel?                   // Cholesterol
    let FAT : GenericMeasureModel?                     // Fats
    let K : GenericMeasureModel?                       // Potassium
    let NA : GenericMeasureModel?                      // Sodium
    let FIBTG : GenericMeasureModel?                   // Carbohydrate : Fiber
    let SUGAR : GenericMeasureModel?                   // Carbohydrate : Sugar
    let CA : GenericMeasureModel?                      // Calcium
    let FE : GenericMeasureModel?                      // Iron
}

struct GenericMeasureModel : Decodable {
    let label : String?
    let quantity : Double?
    let unit : String?
}


struct CustomNutritionModel {
    var nutrition: GenericMeasureModel?
    var percentage: Double?
}
