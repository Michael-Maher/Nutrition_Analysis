//
//  NutritionAnalysisProvider.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import Moya

enum NutritionAnalysisProvider {
    case analysisNutrition(ingredients: [String])
}

extension NutritionAnalysisProvider: TargetType {
   
    
    //==================
    //MARK: Base URL
    //==================
    var baseURL: URL {
        return URL(string: "https://api.edamam.com/api/")!
    }

    //==================
    //MARK: Path
    //==================
    var path: String {
        switch self {
        case .analysisNutrition:
            return "nutrition-details"
        }
    }
    
    //==================
    //MARK: parameters
    //==================
    var parameters: [String: Any] {
        switch self {
        case .analysisNutrition(let ingredients):
            return ["ingr" : ingredients]
        }
    }
    
    //==================
    //MARK: Method
    //==================
    var method: Moya.Method {
        return .post
    }
    
    //======================
    //MARK: Task
    //======================
    var task: Task {
        switch self {
        case .analysisNutrition:
            let urlParameters = ["app_id": "47379841",
                                 "app_key": "d28718060b8adfd39783ead254df7f92"]
            return .requestCompositeParameters(bodyParameters: self.parameters, bodyEncoding: JSONEncoding.default, urlParameters: urlParameters)
        }
    }

    
    //======================
    //MARK: headers
    //======================
    var headers: [String : String]? {
        let headers = ["Accept" : "application/json",
                       "Content-Type" : "application/json"]
        return headers
    }
    
    
    //======================
    //MARK: Sample data
    //======================
    var sampleData: Data {
        return Data()
    }
    
}
