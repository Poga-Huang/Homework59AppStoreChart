//
//  AppPageExtension.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/22.
//

import Foundation
import UIKit

extension AppDetailTableViewController{
    //更新畫面
     func updateUI(with data:AppDetailResponse){
         let responseData = data.results[0]
         ChartController.shared.fetchImage(urlString: responseData.artworkUrl100) { data in
             if let data = data {
                 DispatchQueue.main.async {
                     self.appCoverImageView.image = UIImage(data: data)
                 }
             }
         }
         self.appTitleLabel.text = responseData.trackName
         self.appSubTilteLabel.text = responseData.sellerName
         self.priceButton.configuration?.title = responseData.formattedPrice
         self.appIntroductionTextView.text = responseData.description
         self.ratingCountLabel.text = "\(responseData.userRatingCount)份評分"
         self.ratingLabel.text = String(format: "%.1f", responseData.averageUserRating)
         self.ratingStarImageView.image = ratingStarImage(rating: responseData.averageUserRating)
         self.ageLabel.text = responseData.contentAdvisoryRating
         self.rankLabel.text = "#\(rank)"
         self.appCategoryLabel.text = responseData.genres[0]
         self.artistLabel.text = responseData.artistName
         guard responseData.languageCodesISO2A.count != 1 else{
             return self.languageCountLabel.text = ""
         }
         self.primaryLanguageLabel.text = responseData.languageCodesISO2A[0]
         self.languageCountLabel.text = "+\(responseData.languageCodesISO2A.count-1)個"
         self.fileSizeLabel.text = convertFileSize(Bytes: responseData.fileSizeBytes)
     }
    //評價星星圖片
    func ratingStarImage(rating:Double)->UIImage?{
        var imageName = ""
        switch rating{
        case 0..<0.5:
            imageName = "0"
        case 0.5..<1.0:
            imageName = "0.5"
        case 1.0..<1.5:
            imageName = "1"
        case 1.5..<2.0:
           imageName = "1.5"
        case 2.0..<2.5:
            imageName = "2"
        case 2.5..<3.0:
            imageName = "2.5"
        case 3.0..<3.5:
            imageName = "3"
        case 3.5..<4.0:
            imageName = "3.5"
        case 4.0..<4.5:
            imageName = "4"
        case 4.5..<5.0:
            imageName = "4.5"
        case 5.0:
            imageName = "5"
        default:
            imageName = "0"
        }
        return UIImage(named: imageName)
    }
    //轉換檔案大小
    func convertFileSize(Bytes:String)->String{
        guard let floatFileSize = Float(Bytes)else{return "0"}
        return String(format: "%.1f", (floatFileSize/1024/1024))
    }
}
