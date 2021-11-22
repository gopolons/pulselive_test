//
//  ArticleAPIService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 18/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

//Network API fetches the data from the remote depository

protocol NetworkAPIProtocol {
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void)
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended) -> Void)
}

final class NetworkAPI: NetworkAPIProtocol {
    
    let parser: DataParsingProtocol
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended) -> Void) {
        let fullArticleRequest = AF.request("https://dynamic.pulselive.com/test/native/content/\(id).json")
        
        fullArticleRequest.responseJSON { (data) in
            
            
            let json = JSON(data.data)
            
            self.parser.parseExtendedData(data: json) { article in
                completion(article)
            }

        }
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void) {
        let articleArrayRequest = AF.request("https://dynamic.pulselive.com/test/native/contentList.json")
        
        articleArrayRequest.responseJSON { (data) in
            let json = JSON(data.data)
            
            self.parser.parsePreviewData(data: json) { article in
                completion(article)
            }
            
        }
    }
    
    init(parser: DataParsingProtocol = DataParsing()) {
        self.parser = parser
    }
    
}

