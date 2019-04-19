//
//  UsageCell.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/19/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import UIKit

class UsageCell: UITableViewCell {
    @IBOutlet weak var btnDecreased: UIButton!
    @IBOutlet weak var lblUsage: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    
    var buttonTapped: ((AnualDataUsageRecord) -> Void) = { _ in }
    
    var anualUsage: AnualDataUsageRecord? {
        didSet {
            prepareData()
        }
    }
    
    func prepareData() {
        if let usage = anualUsage {
            lblYear.text = "\(usage.year)"
            lblUsage.text = String(format: "%.6f", usage.total)
            btnDecreased.isHidden = !usage.hasDecreased
            lblYear.textColor = usage.hasDecreased ? .red : .white
            lblUsage.textColor = usage.hasDecreased ? .red : .white
        }
    }
    
    @IBAction func decreasedButtonTapped() {
        if let usage = anualUsage {
            buttonTapped(usage)
        }
    }
}
