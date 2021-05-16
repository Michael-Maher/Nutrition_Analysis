//
//  NutritionTableCell.swift
//  Nutrition_Analysis
//
//  Created by Michael Maher on 5/14/21.
//

import UIKit

class NutritionTableCell: UITableViewCell {

    @IBOutlet weak var nutritionPercentage: UILabel!
    @IBOutlet weak var nutritionValue: UILabel!
    @IBOutlet weak var nutritionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(cellViewModel: NutritionDetailsViewModel) {
        nutritionTitle.text = cellViewModel.title
        nutritionValue.text = cellViewModel.nutritionValue
        nutritionPercentage.text = cellViewModel.percentage
    }
}

extension NutritionTableCell: ReuseIdentifying {}
