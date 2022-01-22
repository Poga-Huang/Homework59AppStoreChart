//
//  AppPageTableViewController.swift
//  Homework59AppStoreChart
//
//  Created by 黃柏嘉 on 2022/1/21.
//

import UIKit

class AppDetailTableViewController: UITableViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //App大資訊欄
    @IBOutlet weak var appCoverImageView: UIImageView!
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var appSubTilteLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    //App小資訊欄
    //評分Rating
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var ratingStarImageView: UIImageView!
    //適齡
    @IBOutlet weak var ageLabel: UILabel!
    //排行
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var appCategoryLabel: UILabel!
    //開發者
    @IBOutlet weak var artistLabel: UILabel!
    //語言
    @IBOutlet weak var primaryLanguageLabel: UILabel!
    @IBOutlet weak var languageCountLabel: UILabel!
    //大小
    @IBOutlet weak var fileSizeLabel: UILabel!
    //App介紹
    @IBOutlet weak var appIntroductionTextView: UITextView!
    @IBOutlet weak var appPreviewCollectionView: UICollectionView!
    
    //變數
    var appId:String?
    var rank:Int?
    var appDetailData:AppDetailResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never
        
        //檢查是否有參數傳入
        if let appId = appId {
            AppDetailController.shared.fetchAppDetailResponse(id:appId) { result in
                switch result{
                case .success(let appPageResponse):
                    self.appDetailData = appPageResponse
                    DispatchQueue.main.async {
                        self.updateUI(with: self.appDetailData!)
                        self.appPreviewCollectionView.reloadData()
                    }
                case .failure(let error):
                    self.displayError(error, title: "資料抓取失敗")
                }
            }
        }
    }
   
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let appPageData = appDetailData {
            return appPageData.results[0].screenshotUrls.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewCell", for: indexPath) as! AppPreviewCollectionViewCell
        
        if let appDetailData = appDetailData {
            ChartController.shared.fetchImage(urlString: appDetailData.results[0].screenshotUrls[indexPath.row]) {data in
                if let data = data {
                    DispatchQueue.main.async {
                        if indexPath == collectionView.indexPath(for: cell){
                            cell.previewImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0:
            return 1
        case 1:
            return 105
        case 2:
            return 630
        case 3:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
}
