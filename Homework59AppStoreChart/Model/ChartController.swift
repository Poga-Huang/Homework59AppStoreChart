//
//  ChartController.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import Foundation


enum ChartCategory:String{
    case free = "top-free/50/apps.json"
    case paid = "top-paid/50/apps.json"
}

internal class ChartController{
    
    static let shared = ChartController()
    
    private let baseURL = URL(string: "https://rss.applemarketingtools.com/api/v2/tw/apps/")!
    
    //抓取API資料
    internal func fetchChartResponse(category:ChartCategory,completion: @escaping (Result<ChartResponse, Error>) -> Void){
        let baseFreeChartURL = baseURL.appendingPathComponent(category.rawValue)
        let task = URLSession.shared.dataTask(with: baseFreeChartURL) { (data,response,error)in
            if let data = data {
                do{
                    let chartResponse = try JSONDecoder().decode(ChartResponse.self, from: data)
                    completion(.success(chartResponse))
                }catch{
                    completion(.failure(error))
                }
            }else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //抓取圖片
    internal func fetchImage(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data{
                completion(data)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

