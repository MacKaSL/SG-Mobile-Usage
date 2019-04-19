//
//  ViewController.swift
//  SG Mobile Usage
//
//  Created by Himal Madhushan on 4/17/19.
//  Copyright © 2019 Himal Madhushan. All rights reserved.
//

import UIKit
import RealmSwift

class UsageListViewController: UITableViewController {

    var usages: Results<AnualDataUsageRecord> {
        return AnualDataUsageRecord.all()
    }
    var notificationToken: NotificationToken?
    
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
        notificationToken?.invalidate()
        HMNetworkManager.fetchDataUsage(success: { (usage) in
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
            }
        }) { (error) in
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.showAlert(title: "Sorry!", message: error?.localizedDescription ?? "Unble to load usage data.")
            }
        }
    }
    
    func initRealmToken() {
        notificationToken = usages.observe { [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: modifications)
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                print("\(error)")
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
