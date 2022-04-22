//
//  CategoryCell.swift
//  FindServices
//
//  Created by Dalvir Singh on 2022-04-05.
//

import UIKit

class CategoryCell : UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
 
    func viewCell (category : String) {
        categoryLabel.text = category
    }
}
