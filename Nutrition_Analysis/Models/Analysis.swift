/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

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
