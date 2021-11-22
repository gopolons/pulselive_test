//
//  ArticleAPIService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 18/11/2021.
//

import Foundation
import Alamofire


//Network API fetches the data from the remote depository

protocol NetworkAPIProtocol {
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void)
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended) -> Void)
}

enum NetworkError: Error {
    case noConnection
    case wrongReference
}

final class NetworkAPI: NetworkAPIProtocol {
    
    private let parser: DataParsingProtocol
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended) -> Void) {
        let fullArticleRequest = AF.request("https://dynamic.pulselive.com/test/native/content/\(id).json")
        
        fullArticleRequest.responseJSON { (data) in
            
            guard data.data != nil else {
                return
            }
            
            self.parser.parseExtendedData(data: data.data!) { article in
                completion(article)
            }

        }
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void) {
        let articleArrayRequest = AF.request("https://dynamic.pulselive.com/test/native/contentList.json")
        
        articleArrayRequest.responseJSON { (data) in
            
            guard data.data != nil else {
                return
            }
            
            self.parser.parsePreviewData(data: data.data!) { article in
                completion(article)
            }
            
        }
    }
    
    init(parser: DataParsingProtocol = DataParsing()) {
        self.parser = parser
    }
    
}

