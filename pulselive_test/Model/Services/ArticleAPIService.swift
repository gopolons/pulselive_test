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
    func fetchPreviewData(completion: @escaping (ArticlePreview?, NetworkError?) -> Void)
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void)
}

enum NetworkError: Error {
    case noConnection
    case wrongReference
}

final class NetworkAPI: NetworkAPIProtocol {
    
    private let parser: DataParsingProtocol
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void) {
        if Connectivity.isConnectedToInternet {
            let fullArticleRequest = AF.request("https://dynamic.pulselive.com/test/native/content/\(id).json")
            
            fullArticleRequest.responseJSON { (data) in
                
                guard data.error == nil else {
                    completion(nil, NetworkError.wrongReference)
                    return
                }
                
                self.parser.parseExtendedData(data: data.data!) { article in
                    completion(article, nil)
                }

            }
        } else {
            completion(nil, NetworkError.noConnection)
        }
        
        
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview?, NetworkError?) -> Void) {
        if Connectivity.isConnectedToInternet {
            let articleArrayRequest = AF.request("https://dynamic.pulselive.com/test/native/contentList.json")
            
            articleArrayRequest.responseJSON { (data) in
                
                guard data.error == nil else {
                    completion(nil, NetworkError.wrongReference)
                    return
                }
                
                self.parser.parsePreviewData(data: data.data!) { article in
                    completion(article, nil)
                }
                
            }
        } else {
            completion(nil, NetworkError.noConnection)
        }
        
        
    }
    
    init(parser: DataParsingProtocol = DataParsing()) {
        self.parser = parser
    }
    
}

