//
//  ViewController.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/17/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import UIKit

class UsageListViewController: UITableViewController {

    var usages: [AnualDataUsageRecord] = []
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - API
    func fetchData() {
        HMNetworkManager.fetchDataUsage(success: { (usages) in
            self.usages = usages
            self.tableView.reloadData()
        }) { (error) in
            
        }
    }
}


// MARK: - Table View Data Source
extension UsageListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsageCell", for: indexPath) as! UsageCell
        cell.anualUsage = usages[indexPath.row]
        cell.buttonTapped = { usage in
            
        }
        return cell
    }
    
}
