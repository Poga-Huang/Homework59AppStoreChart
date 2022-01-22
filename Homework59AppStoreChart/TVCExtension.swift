//
//  extension.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import Foundation
import UIKit

extension UITableViewController{
    //跳出資料下載錯誤警告
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //更新畫面
    func configure(_ cell:AppTableViewCell,forRowAt indexPath:IndexPath,data:ChartResponse){
        cell.appNameLabel.text = data.feed.results[indexPath.row].name
        cell.sequenceLabel.text = "\(indexPath.row+1)"
        cell.artistNameLabel.text = data.feed.results[indexPath.row].artistName
        
        ChartController.shared.fetchImage(urlString: data.feed.results[indexPath.row].artworkUrl100) { (data) in
            DispatchQueue.main.async {
                if indexPath == self.tableView.indexPath(for: cell){
                    if let data = data {
                        cell.appImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
