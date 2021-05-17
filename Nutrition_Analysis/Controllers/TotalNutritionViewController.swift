//
//  NutritionViewController.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/14/21.
//

import UIKit
import RxSwift
import RxCocoa

class TotalNutritionViewController: UIViewController {

    //==========================
    //MARK: - Outlets
    //==========================
    @IBOutlet weak var nutritionFactsTableView: UITableView!
    
    //==========================
    //MARK: - Variables
    //==========================
    var nutritionViewModel: NutritionViewModel?
    let rowHeight: CGFloat = 50
    let disposeBag = DisposeBag()
    
    //=================================
    //MARK: - View life cycle methods
    //=================================
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    //=================================
    //MARK: - Methods
    //=================================
    private func setupUI() {
        title = "Total nutrition"
        configureTableView()
        
        bindData()
        nutritionViewModel?.loadData()
    }
    
    private func configureTableView() {
        let nib = UINib(nibName: NutritionTableCell.reuseIdentifier, bundle: nil)
        nutritionFactsTableView.register(nib, forCellReuseIdentifier: NutritionTableCell.reuseIdentifier)
        nutritionFactsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001)) // to remove separator from last cell in the table
        nutritionFactsTableView.rowHeight = rowHeight
    }
    
    private func bindData() {
        guard let nutritionViewModel = nutritionViewModel else {
            fatalError("Unexpected viewModel type")
        }
        
        // configure table view data source        
        nutritionViewModel.totalNutrition
            .drive(nutritionFactsTableView.rx.items(cellIdentifier: NutritionTableCell.reuseIdentifier)) {(index, nutrition: CustomNutritionModel, cell) in
                guard let nutritionTableCell = cell as? NutritionTableCell else {
                    return
                }
                let nutritionCellViewModel = NutritionDetailsViewModel(nutrition: nutrition)
                nutritionTableCell.configureCell(cellViewModel: nutritionCellViewModel)
            }.disposed(by: disposeBag)
    }

}
