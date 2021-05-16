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
        
        
//        passengerProvider.request(.sendCode(phone: phone)) { (result) in
//            let response = result.value
//            switch result {
//            case .success:
//                do {
//                    let result = try jsonDecoder.decode(GenericApiMessageModel.self, from: response?.data ?? Data())
//                    if result.status == 1 { // this check must be like this as many times status doesn't return
//                        print("\n\nverfication code: \(result.message ?? "")")
//                        completion(result, nil)
//                    } else {
//                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "Error happened"]) as Error
//                        completion(nil, error)
//                    }
//                } catch {
//                    print("sendCode info parse error: \(error)")
//                    completion(nil, error)
//                }
//            case .failure(let error):
//                do {
//                    let result = try jsonDecoder.decode(GenericApiMessageModel.self, from: response?.data ?? Data())
//                    if result.status == 1 {
//                        completion(nil, error)
//                    } else {
//                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: result.message ?? "Error happened"]) as Error
//                        completion(nil, error)
//                    }
//                } catch {
//                    print("sendCode info parse error: \(error)")
//                    completion(nil, error)
//                }
//            }
//        }
    }
}
