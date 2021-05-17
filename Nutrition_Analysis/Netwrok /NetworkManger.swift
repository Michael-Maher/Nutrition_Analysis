//
//  NetworkManger.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import Moya
import RxSwift

class NetworkManger {
    static let provider = MoyaProvider<NutritionAnalysisProvider>(plugins: [NetworkLoggerPlugin()])

    static var jsonDecoder = JSONDecoder()
    
    
    //MARK:- Analysis Nutrition
    static func analysisNutrition(ingredients: [String]) -> Observable<Analysis> {
        
        provider.rx
            .request(.analysisNutrition(ingredients: ingredients))
            .filterSuccessfulStatusCodes()
            .map(Analysis.self)
            .asObservable()
        
    }
}
