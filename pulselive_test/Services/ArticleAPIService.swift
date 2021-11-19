//
//  ArticleAPIService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 18/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkAPIProtocol {
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void)
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended) -> Void)
}

final class NetworkAPI: NetworkAPIProtocol {
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended) -> Void) {
        let fullArticleRequest = AF.request("https://dynamic.pulselive.com/test/native/content/\(id).json")
        
        fullArticleRequest.responseJSON { (data) in
            let json = JSON(data.data)
            for x in json {
                
                for n in x.1 {
                    let id: Int = n.1["id"].intValue
                    let title: String = n.1["title"].stringValue
                    let subtitle: String = n.1["subtitle"].stringValue
                    let body: String = n.1["body"].stringValue
                    let date: String = n.1["date"].stringValue

                    let article = ArticleExtended(id: id, title: title, subtitle: subtitle, date: date, body: body)
                    completion(article)
                }
            }
        }
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void) {
        let articleArrayRequest = AF.request("https://dynamic.pulselive.com/test/native/contentList.json")
        
        articleArrayRequest.responseJSON { (data) in
            let json = JSON(data.data)
            for x in json {
                
                for n in x.1 {
                    let id: Int = n.1["id"].intValue
                    let title: String = n.1["title"].stringValue
                    let subtitle: String = n.1["subtitle"].stringValue
                    let date: String = n.1["date"].stringValue

                    let preview = ArticlePreview(id: id, title: title, subtitle: subtitle, date: date)
                    completion(preview)
                }
            }
        }
    }
}

