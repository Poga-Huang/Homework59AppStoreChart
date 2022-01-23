//
//  ChartTableViewController.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import UIKit
import StoreKit
private let reusableIdentifier = "freeCell"
private let segueIdentifier = "FreeShowAppPage"

class FreeAppsTableViewController: UITableViewController{
    
    
    var freeApps:ChartResponse?
    var selectAppId:String?
    var appRank:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下載資料
        ChartController.shared.fetchChartResponse(category: .free) { result in
            switch result{
            case .success(let chartResponse):
                DispatchQueue.main.async {
                    self.freeApps = chartResponse
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.displayError(error, title: "App資料抓取失敗")
            }
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if freeApps == nil{
            return 0
        }else{
           return freeApps!.feed.results.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! AppTableViewCell
        if let freeApps = freeApps {
            configure(cell, forRowAt:indexPath , data: freeApps)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectAppId = freeApps?.feed.results[indexPath.row].id
        appRank = indexPath.row+1
        if selectAppId != nil && appRank != nil{
            performSegue(withIdentifier: segueIdentifier, sender: nil)
        }else{
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    //傳值
    @IBSegueAction func passFreeAppsData(_ coder: NSCoder) -> AppDetailTableViewController? {
        guard let selectAppId = selectAppId else {
            return nil
        }
        guard let appRank = appRank else {
            return nil
        }
        return AppDetailTableViewController(coder: coder, appId: selectAppId, rank: appRank)
    }
    
    
}
