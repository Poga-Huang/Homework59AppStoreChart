//
//  chart.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import Foundation


struct ChartResponse:Decodable{
    var feed:Feed
    struct Feed:Decodable{
        var results:[Results]
        struct Results:Decodable{
            var artistName:String
            var id:String
            var name:String
            var artworkUrl100:String
        }
    }
}

struct AppDetailResponse:Decodable{
    var results:[Results]
    struct Results:Decodable{
        var screenshotUrls:[String]
        var artworkUrl100:String
        var fileSizeBytes:String
        var formattedPrice:String
        var contentAdvisoryRating:String
        var averageUserRating:Double
        var trackName:String
        var sellerName:String
        var description:String
        var artistName:String
        var languageCodesISO2A:[String]
        var genres:[String]
        var userRatingCount:Int
    }
}

