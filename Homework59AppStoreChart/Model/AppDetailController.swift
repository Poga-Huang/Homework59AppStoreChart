//
//  AppPageController.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import Foundation

internal class AppDetailController{
    
    static let shared = AppDetailController()
    
    internal func fetchAppDetailResponse(id:String,completion:@escaping (Result<AppDetailResponse,Error>)->Void){
        guard let baseURL = getURL(id: id) else{return}
        URLSession.shared.dataTask(with: baseURL) { (data, response, error)in
            if let data = data {
                do{
                    let appDetailResponse = try JSONDecoder().decode(AppDetailResponse.self, from: data)
                    completion(.success(appDetailResponse))
                }catch{
                    completion(.failure(error))
                }
            }else if let error = error {
                completion(.failure(error))
            }
        }.resume()
        
    }

    private func getURL(id:String)->URL?{
        var urlComponents = URLComponents()
        urlComponents.host = "itunes.apple.com"
        urlComponents.scheme = "https"
        urlComponents.path = "/lookup"
        urlComponents.query = "id=\(id)&country=tw"
        return urlComponents.url
    }
    
    
}
