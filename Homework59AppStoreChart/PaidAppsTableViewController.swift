//
//  PaidAppsTableViewController.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import UIKit
private let reusableIdentifier = "paidCell"
private let segueIdentifier = "PaidShowAppPage"

class PaidAppsTableViewController: UITableViewController {
    
    var paidApps:ChartResponse?
    var selectAppId:String?
    var appRank:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ChartController.shared.fetchChartResponse(category: .paid) { result in
            switch result{
            case .success(let chartResponse):
                DispatchQueue.main.async {
                    self.paidApps = chartResponse
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.displayError(error, title: "App資料抓取失敗")
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if paidApps == nil{
            return 0
        }else{
           return paidApps!.feed.results.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! AppTableViewCell
        if let paidApps = paidApps {
            configure(cell, forRowAt: indexPath, data: paidApps)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectAppId = paidApps?.feed.results[indexPath.row].id
        appRank = indexPath.row+1
        if selectAppId != nil && appRank != nil{
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }else{
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    //傳值
    @IBSegueAction func passPaidAppsData(_ coder: NSCoder) -> AppDetailTableViewController? {
        guard let selectAppId = selectAppId else {
            return nil
        }
        guard let appRank = appRank else {
            return nil
        }
        return AppDetailTableViewController(coder: coder, appId: selectAppId, rank: appRank)
    }
    
   
}

