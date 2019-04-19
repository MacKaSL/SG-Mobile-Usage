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
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(UsageListViewController.fetchData), for: .valueChanged)
        fetchData()
        self.title = "Mobile Data Usages"
    }

    // MARK: - API
    @objc func fetchData() {
        self.tableView.refreshControl?.beginRefreshing()
        HMNetworkManager.fetchDataUsage(success: { (usage) in
            self.usages = usage
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
                self.showAlert(title: "Sorry!", message: error?.localizedDescription ?? "Unble to load usage data.")
            }
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


// MARK: - Table View Delegate
extension UsageListViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
