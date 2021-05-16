//
//  IngredientDetailsTableCell.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/4/21.
//

import UIKit
import RxSwift
import RxCocoa

class IngredientDetailsTableCell: UITableViewCell {
    //===================
    //MARK:- Outlets
    //===================
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var separatorLine: UIView!
    
    //===================
    //MARK:- Variables
    //===================
    var ingredientDetailsViewModel: IngredientDetailsViewModel!
//    var isHeaderCell: Bool {
//        didSet {
//            if isHeaderCell
//        }
//    }
    
    //===================
    //MARK:- Methods
    //===================
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(ingredientDetailsViewModel: IngredientDetailsViewModel) {
        
        quantityLabel.text = ingredientDetailsViewModel.qty
        unitLabel.text = ingredientDetailsViewModel.unit
        foodLabel.text = ingredientDetailsViewModel.food
        caloriesLabel.text = ingredientDetailsViewModel.calories
        weightLabel.text = ingredientDetailsViewModel.wright
        separatorLine.isHidden = true
    }
    
    func configureHeader() {
        quantityLabel.text = "Qty"
        unitLabel.text = "Unit"
        foodLabel.text = "Food"
        caloriesLabel.text = "Calories"
        weightLabel.text = "Weight"
        separatorLine.isHidden = false
    }
    
}
extension IngredientDetailsTableCell: ReuseIdentifying {}
