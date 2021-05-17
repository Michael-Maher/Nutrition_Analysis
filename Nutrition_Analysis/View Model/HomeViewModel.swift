//
//  HomeViewModel.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import Foundation
import RxSwift
import RxCocoa

// Error Type
enum CustomError {
    case underlyingError(Error)
    case errorInSpecificIngr(String)
}

class HomeViewModel {
    
    private let disposeBag = DisposeBag()
    
    var analysisSubject = BehaviorRelay<Analysis?>(value: nil)

    private let ingredientsSubject = PublishSubject<[Ingredients]>()
    var ingredients: Driver<[Ingredients]> {
        return ingredientsSubject
            .asDriver(onErrorJustReturn: [])
    }
    
    private let errorSubject = PublishSubject<CustomError?>()
    var error: Driver<CustomError?> {
        return errorSubject
            .asDriver(onErrorJustReturn: nil)
    }
    
    private let loadingSubject = PublishSubject<Bool>()
    var isLoading: Driver<Bool> {
        return loadingSubject
            .asDriver(onErrorJustReturn: false)
    }
    
    private let searchSubject = PublishSubject<String>()
    var searchObserver: AnyObserver<String> {
        return searchSubject.asObserver()
    }
    
    init() {

        searchSubject
            .asObservable()
            .filter { !$0.isEmpty }
            
            .flatMapLatest { [unowned self] term -> Observable<Analysis> in
                
                self.loadingSubject.onNext(true)
                let ingr = term.split(whereSeparator: \.isNewline).map({String($0)})
                
                
                return NetworkManger.analysisNutrition(ingredients: ingr)
                    .catchError { [unowned self] error -> Observable<Analysis> in
                        self.errorSubject.onNext(CustomError.underlyingError(error))
                        self.loadingSubject.onNext(false)
                        return Observable.empty()
                    }
            }
            .subscribe(onNext: { [unowned self] response in
                self.loadingSubject.onNext(false)
                
                if response.ingredients?.isEmpty ?? true {
                    let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: "Can't get ingredients right now!"]) as Error
                    self.errorSubject.onNext(CustomError.underlyingError(error))
                } else {
                    analysisSubject.accept(response)
                    let ingrs = response.ingredients ?? []
                    let loadedCorrectlyIngrs = ingrs.filter({$0.parsed != nil})
                    if loadedCorrectlyIngrs.isEmpty {
                        let error = NSError(domain:"", code:400, userInfo:[ NSLocalizedDescriptionKey: "Can't get ingredients right now!"]) as Error
                        self.errorSubject.onNext(CustomError.underlyingError(error))
                    } else {
                        if loadedCorrectlyIngrs.count < ingrs.count {
                            let errorMsg = "We cannot calculate the nutrition for some ingredients.\nPlease check the ingredient spelling or if you have entered a quantities for the ingredients."
                            self.errorSubject.onNext(CustomError.errorInSpecificIngr(errorMsg))
                        }
                        self.ingredientsSubject.onNext(loadedCorrectlyIngrs)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
