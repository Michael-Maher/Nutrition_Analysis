//
//  HomeViewController.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    //==========================
    //MARK: - Outlets
    //==========================
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var recipeTextView: UITextView!
    @IBOutlet weak var analyzeBtn: UIButton!
    @IBOutlet weak var newRecipeBtn: UIButton!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var totalNutritionBtn: UIButton!
    @IBOutlet weak var totalBtnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    //==========================
    //MARK: - Variables
    //==========================
    var homeViewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    let rowHeight: CGFloat = 50
    
    //=================================
    //MARK: - View life cycle methods
    //=================================
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindData()
        handleUIEvents()
    }
    
    //=================================
    //MARK: - Methods
    //=================================
    private func setupUI() {
        homeViewModel = HomeViewModel()
        
        recipeTextView.addCornersAndBorders(radius: 10)
        recipeTextView.addFadeShadow()

        configureTableView()
    }
    
    private func configureTableView() { // customize ingredients Table View
        let nib = UINib(nibName: IngredientDetailsTableCell.reuseIdentifier, bundle: nil)
        ingredientsTableView.register(nib, forCellReuseIdentifier: IngredientDetailsTableCell.reuseIdentifier)
        ingredientsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001)) // to remove separator from last cell in the table
        ingredientsTableView.rowHeight = rowHeight
        ingredientsTableView.sectionHeaderHeight = rowHeight
    }
    
    private func bindData() {
        guard let homeViewModel = homeViewModel else {
            fatalError("Unexpected viewModel type")
        }
        
        // set table view delegate to self to add header view
        ingredientsTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        
        // show/hide loading indicator
        homeViewModel.isLoading.asDriver().drive { [unowned self](isLoading) in
            if isLoading {
                Loader.startIndicator(view: analyzeBtn, loaderColor: .white)
            } else {
                Loader.removeLoader(view: analyzeBtn)
            }
        }.disposed(by: disposeBag)
        
        
        // configure table view data source
        homeViewModel.ingredients
            .drive(ingredientsTableView.rx.items(cellIdentifier: IngredientDetailsTableCell.reuseIdentifier)) {(index, ingredient: Ingredients, cell) in
                guard let ingredientDetailsCell = cell as? IngredientDetailsTableCell else {
                    return
                }
                let ingredientCellViewModel = IngredientDetailsViewModel(ingr: ingredient)
                ingredientDetailsCell.configureCell(ingredientDetailsViewModel: ingredientCellViewModel)
            }.disposed(by: disposeBag)
        
        
        // handle table height and total button show/hide
        homeViewModel.ingredients.asDriver()
            .drive(onNext: { [unowned self] ingredients in
                totalBtnHeightConstraint.constant = ingredients.isEmpty ? 0 : 40
                tableViewHeight.constant = (CGFloat(ingredients.count) * rowHeight) + rowHeight // + rowHeight for header cell height
                newRecipeBtn.isHidden = ingredients.isEmpty
                analyzeBtn.setNeedsDisplay()
                UIView.animate(withDuration: 0.5) {[unowned self] in
                    view.layoutIfNeeded()
                }
            }).disposed(by: disposeBag)
        
        
        // handle error types
        homeViewModel.error
            .drive(onNext: {[unowned self] error in
                switch error {
                case .errorInSpecificIngr(let errorMsg):
                    AlertsManager.showAlert(withTitle: "", message: errorMsg, viewController: self)
                case .underlyingError(let error):
                    AlertsManager.showAlert(withTitle: "", message: error.localizedDescription, viewController: self, actionTitle: "Ok, got it!", actionStyle: .default, actionHandler: {[unowned self]_ in
                        //Reset view
                        resetView()
                    })
                case .none:
                    AlertsManager.showAlert(withTitle: "", message: "Something wrong happen!", viewController: self)
                }
            }).disposed(by: disposeBag)
        
    }
    
    private func handleUIEvents() {
        // Handle tap event for new recipe button
        newRecipeBtn.rx
            .tap
            .throttle(RxTimeInterval.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe { [unowned self]_ in
                resetView()
            }.disposed(by: disposeBag)
        
        // Handle tap event for analyze button
        analyzeBtn.rx
            .tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [unowned self]_ in
                homeViewModel.searchObserver.onNext(recipeTextView.text ?? "")
            }.disposed(by: disposeBag)
        
        // Handle text changes for text view
       let isValidInputObservable = recipeTextView.rx
            .text
            .orEmpty
            .debounce(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .map({ text in
                // Analyze btn will be enabled when :
                // 1. Number of characters >= 3
                // 2. text start with number at the beginning
                // EX: 1 cup rice >> is accepted,
                //           rice >> not accepted
                 return text.hasMinimumNumberOfLetters(3) && text.isOnlyNumbers
            })
           
        // Handle total button tap action
        totalNutritionBtn.rx
            .tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe { [unowned self]_ in

                guard let nutritionViewController = storyboard?.instantiateViewController(withIdentifier: "TotalNutritionViewController") as? TotalNutritionViewController else { return }

                nutritionViewController.nutritionViewModel = NutritionViewModel(analysis: homeViewModel.analysisSubject.value)
                navigationController?.pushViewController(nutritionViewController, animated: true)
            }.disposed(by: disposeBag)
        
        
        // Enable/Disable analyze button according to regix match
        isValidInputObservable
            .bind(to: analyzeBtn.rx.isEnabled)
            .disposed(by: disposeBag)
                
        // change background color of analyze button according to state (normal / disabled)
        isValidInputObservable
            .map({
                return $0 ? #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1) : UIColor.lightGray
            })
            .subscribe { [unowned self](color) in
                analyzeBtn.backgroundColor = color
            }.disposed(by: disposeBag)
    }
    
    
    private func resetView() { // reset all view and heights
        tableViewHeight.constant = 0
        totalBtnHeightConstraint.constant = 0
        
        newRecipeBtn
            .rx
            .isHidden
            .onNext(true)
        
        analyzeBtn.rx
            .isEnabled
            .onNext(false)
        
        recipeTextView
            .rx
            .text
            .onNext("")
        
        UIView.animate(withDuration: 0.5) {[unowned self] in
            view.layoutIfNeeded()
        }
    }

}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientDetailsTableCell.reuseIdentifier) as?  IngredientDetailsTableCell else { return nil}
        cell.configureHeader()
        return cell.contentView
    }
    
}

